require.context('govuk-frontend/dist/govuk/assets');

import '../styles/application.scss';
import Rails from 'rails-ujs';
import { initAll } from 'govuk-frontend';

Rails.start();
initAll();
