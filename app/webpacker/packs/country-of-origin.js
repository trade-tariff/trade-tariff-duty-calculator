import accessibleAutocomplete from 'accessible-autocomplete'

accessibleAutocomplete.enhanceSelectElement({
  defaultValue: '',
  selectElement: document.querySelector('[id^="wizard-steps-country-of-origin-country-of-origin-field"]')
})
