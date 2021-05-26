import CountryAutocomplete from '../packs/country_autocomplete';

var country_autocomplete = new CountryAutocomplete();
var target = document.querySelector('[id^="wizard-steps-country-of-origin-country-of-origin-field"]')

country_autocomplete.enhanceElement(target);

