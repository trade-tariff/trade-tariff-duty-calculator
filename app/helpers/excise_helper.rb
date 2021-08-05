module ExciseHelper
  def sanitized_excise_hint
    hint_text = t(
      'excise_page.hint_html',
      small_brewers_relief_hint_text: small_brewers_relief_hint_text,
      excise_link: excise_link,
    )

    sanitize(hint_text, attributes: %w[href target class])
  end

  private

  def small_brewers_relief_hint_text
    # rubocop:disable Rails/HelperInstanceVariable
    t('excise_page.small_brewers_relief_hint_text_html', small_brewers_relief_link: small_brewers_relief_link) if @step.small_brewers_relief?
    # rubocop:enable Rails/HelperInstanceVariable
  end

  def excise_link
    link_to(
      t('excise_page.link_text'),
      'https://www.gov.uk/government/publications/uk-trade-tariff-excise-duties-reliefs-drawbacks-and-allowances/uk-trade-tariff-excise-duties-reliefs-drawbacks-and-allowances',
      class: 'govuk-link',
      target: '_blank',
      rel: 'noopener',
    )
  end

  def small_brewers_relief_link
    link_to(
      t('excise_page.small_brewers_relief_link_text'),
      'https://www.gov.uk/government/publications/excise-notice-226-beer-duty/excise-notice-226-beer-duty--2#small-brewery-beer',
      class: 'govuk-link',
      target: '_blank',
      rel: 'noopener',
    )
  end
end
