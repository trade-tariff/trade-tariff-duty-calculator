require.context('govuk-frontend/dist/govuk/assets');

import '../styles/application.scss';
import Rails from 'rails-ujs';
import { initAll } from 'govuk-frontend/dist/govuk/govuk-frontend.min.js';

require('../src/javascripts/google-tag-manager-loader.js');
require('../src/javascripts/cookie-manager.js');

Rails.start();
initAll();
