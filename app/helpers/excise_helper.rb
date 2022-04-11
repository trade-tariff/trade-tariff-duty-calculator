module ExciseHelper
  def excise_hint(small_brewers_relief:)
    extra_brewers_hint = small_brewers_relief ? small_brewers_relief_hint_text : nil

    t(
      'excise_page.hint_html',
      small_brewers_relief_hint_text: extra_brewers_hint,
      excise_link:,
    )
  end

  private

  def small_brewers_relief_hint_text
    t('excise_page.small_brewers_relief_hint_text_html', small_brewers_relief_link:)
  end

  def excise_link
    link_to(
      t('excise_page.link_text'),
      'https://www.gov.uk/government/publications/uk-trade-tariff-excise-duties-reliefs-drawbacks-and-allowances/uk-trade-tariff-excise-duties-reliefs-drawbacks-and-allowances',
      class: 'govuk-link',
      target: '_blank',
      rel: 'noopener norefferer',
    )
  end

  def small_brewers_relief_link
    link_to(
      t('excise_page.small_brewers_relief_link_text'),
      'https://www.gov.uk/government/publications/excise-notice-226-beer-duty/excise-notice-226-beer-duty--2#small-brewery-beer',
      class: 'govuk-link',
      target: '_blank',
      rel: 'noopener norefferer',
    )
  end
end
