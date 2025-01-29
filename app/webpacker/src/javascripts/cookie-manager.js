import Cookies from 'js-cookie';

export default class CookieManager {
  constructor() {
    this.cookiesPolicyName = 'cookies_policy';
    this.cookiesHideConfirmName = 'cookies_preferences_set';
    this.cookiesTreeOpenClosedDefault = 'tree_open_close_default';
    this.expiresInOneYear = 365;
    this.expiresInTwentyEightDays = 28;
  }

  rememberSettings() {
    const rememberSettings = this.getCookiesPolicy()?.remember_settings;
    return rememberSettings === 'true' ? true : rememberSettings === 'false' ? false : rememberSettings || false;
  }

  usage() {
    const usage = this.getCookiesPolicy()?.usage;
    return usage === 'true' ? true : usage === 'false' ? false : usage || false;
  }

  shouldOpenTree() {
    return this.getCookiesTreeOpenClosedDefault() === 'open';
  }

  showAcceptRejectCookiesBanner() {
    return !this.getCookiesPolicy();
  }

  showHideConfirmCookiesBanner() {
    return this.getCookiesHideConfirm() === null;
  }

  setCookiesPolicy(value = {usage: true, remember_settings: true}) {
    this.#setCookie(this.cookiesPolicyName, value, this.expiresInOneYear);
  }

  getCookiesPolicy() {
    return this.#getCookie(this.cookiesPolicyName);
  }

  setCookiesHideConfirm(value = {value: true}) {
    this.#setCookie(this.cookiesHideConfirmName, value, this.expiresInOneYear);
  }

  getCookiesHideConfirm() {
    return this.#getCookie(this.cookiesHideConfirmName);
  }

  setCookiesTreeOpenClosedDefault(value = {value: 'open'}) {
    this.#setCookie(this.cookiesTreeOpenClosedDefault, value, this.expiresInTwentyEightDays);
  }

  getCookiesTreeOpenClosedDefault() {
    return this.#getCookie(this.cookiesTreeOpenClosedDefault)?.value || 'open';
  }

  #setCookie(name, value, expires) {
    const isSecureEnvironment = location.protocol === 'https:';
    const encodedValue = JSON.stringify(value);

    Cookies.set(name, encodedValue, {
      expires: expires,
      secure: isSecureEnvironment,
      sameSite: 'Strict',
    });
  }

  #getCookie(name) {
    const candidateJson = Cookies.get(name);

    if (!candidateJson) {
      return null;
    }

    try {
      return JSON.parse(candidateJson);
    } catch (e) {
      return candidateJson;
    }
  }
}
