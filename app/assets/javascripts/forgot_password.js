
    
var Y = YAHOO,
    Dom  = Y.util.Dom,
    Select = Y.util.Selector,
    Ajax = Y.util.Connect,
    Lang = Y.lang;

/**
* Manages forgot password related operations
* @class SGForgotPwd
* @constructor
* @param {String|HTMLFormElement} form
*/
function SGForgotPwd (form) {
    this.formEl  = Dom.get(form);
    if ( this.formEl ) {
      this.emailEl = this.formEl.email_id;
      this.captcha = this.formEl.captcha;
      this.submitButton = Select.query('button[type=submit]', this.formEl, true);
      this.submitBtnTxtElem = Select.query('span span', this.submitButton, true);
  
      this.errorStatusEl = Dom.get('forgot_pwd_status');
      
      this.processing = false;
      this.emailValidated = true;
      this.captchaProcessing = false;
  
      //attach event handlers
      Y.util.Event.on(this.formEl, 'submit', this._submit, this, true);
      Y.util.Event.on(this.emailEl, 'change', this._validateEmail, this, true);
      Y.util.Event.on('refresh_captcha', 'click', this.refreshCaptcha, this, true);
  
      this.emailEl.value = location.hash.substring(1);
      this.emailEl.focus();
    }
}

SGForgotPwd.prototype._submit = function (e) {
    Y.util.Event.stopEvent(e);
    
    if(this.processing) return;

    if (!this.validate(e)){ return; }
    
    if (this.submitBtnTxtElem.innerHTML != "") this.submitBtnTxtElem.innerHTML = "Processing...Please wait";
    //else Dom.setStyle(this.submitButton, 'background', 'transparent url(/ce/pulse/images/processing.png) no-repeat' );
      
    var callback = {
        success : function (xhr) {
            var resp = eval('(' + xhr.responseText + ')');
            if (resp.success) {
                this.errorStatusEl.innerHTML = resp.notice;
                Dom.setStyle(this.errorStatusEl, 'visibility', 'visible');
            }else {
                this.errorStatusEl.innerHTML = resp.error;
                Dom.setStyle(this.errorStatusEl, 'visibility', 'visible');
            }
            if (this.submitBtnTxtElem.innerHTML != "") this.submitBtnTxtElem.innerHTML = "Reset Password";
            //else Dom.setStyle(this.submitButton, 'background', 'transparent url(/ce/pulse/images/reset_pword.png) no-repeat' );

            this.processing = false;
            this.refreshCaptcha();
        },
        
        failure : function (xhr) {
            var err_str = '';            
            switch(xhr.status) {
                case 0:
                    err_str = 'Unable to connect to server. Please check your internet connection.';
                    break
                default:
                    err_str = 'Unable to continue at this time. Please try again after some time.';
            }
            
            this.errorStatusEl.innerHTML = err_str;
            Dom.setStyle(this.errorStatusEl, 'visibility', 'visible');

            if (this.submitBtnTxtElem.innerHTML != "") this.submitBtnTxtElem.innerHTML = "Reset Password";
            //else Dom.setStyle(this.submitButton, 'background', 'transparent url(/ce/pulse/images/reset_pword.png) no-repeat' );

            this.processing = false;
            this.refreshCaptcha();
        },
        
        scope : this
    }
    
    this.processing = true;
    Ajax.setForm(this.formEl);
    Ajax.asyncRequest('POST', 'forgot_password', callback); // '/ce/login/forgot_password'
}

SGForgotPwd.prototype.validate = function (e) {

    if (!this._validateEmail(e)) { return false; }

    return true;
}

SGForgotPwd.prototype._validateEmail = function (e) {
    
    /**
    * Checks whether specified email is a valid email id or not
    * @param {String} email
    * @return {Boolean}
    */
    var validEmail = function (email) {
        var reg = /^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
        return reg.test(email);
    };
    
    //validate email syntax in client side
    if (!validEmail(this.emailEl.value)) {
        this.onerror(this.emailEl, 'Please enter a valid Email Id');
        return false;
    }
    
    //clear
    this.onsuccess(this.emailEl);
    this.emailValidated = true;

    return true;
}

SGForgotPwd.prototype.onerror = function (el, error_text) {
    var error_el = Select.query('em', el.parentNode, true);
    error_el.innerHTML = error_text;
    el.focus();
    Dom.removeClass(error_el, 'loading');

    return error_el;
}

SGForgotPwd.prototype.onsuccess = function (el) {
    var em = Select.query('em', el.parentNode, true);
    em.innerHTML = '';
    Dom.removeClass(em, 'loading');
    return em;
}

SGForgotPwd.prototype.refreshCaptcha = function (e) {
    try {
        Y.util.Event.stopEvent(e);
    }catch(e){}
    
    if (this.captchaProcessing === true) { return false;  }

    this.captchaProcessing = true;

    var em = Select.query('em', this.captcha.parentNode, true);
    em.innerHTML = '&nbsp;';
    Dom.addClass(em, 'loading');

    var callback = {
        success : function (xhr) {
            // we had to hack the response to remove 'Prototype' dependency 
            // extract image src from the response            
            var match = xhr.responseText.match(/src=\\"([^"]*)\\"/);

            if (match && match[1]) {
                Select.query('#simple_captcha img', null, true).src = match[1];
            }

            this.captchaProcessing = false;
            Dom.removeClass(em, 'loading');
        },
        cache : false,
        scope : this
    };

    Ajax.asyncRequest('GET', '/felix/refresh_captcha', callback);
}
