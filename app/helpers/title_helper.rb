class TitleHelper
  def title_for(opts)
    step = opts[:step]

    t("page_titles.#{step.class.id}")
  end

  private

  def default_title
    t("title.#{referred_service}")
  end

  def step_title_for(step)
  end

  def interstitial_title
    return t('page_titles.interstitial.gb_to_ni') if user_session.gb_to_ni_route?

    t('page_titles.interstitial.default')
  end

  def duty_title_for(duty_options)
    t('page_titles.duty_calculation') if duty_options.present?

    t('page_titles.no_duty')
  end

  def referred_service
    params[:referred_service] || session['referred_service'] || 'uk'
  end
end
