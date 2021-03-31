module ApplicationHelper
  def self.humanize_datetime(date)
    date.strftime('%d/%m/%Y às %H:%M')
  end

  def self.humanize_date(date)
    date.strftime('%d/%m/%Y')
  end

  def self.humanize_time(date)
    date.strftime('%H:%M')
  end

  def self.humanize_cpf(cpf)
    "#{cpf[0..2]}.#{cpf[3..5]}.#{cpf[6..8]}-#{cpf[9..11]}"
  end

  def business_day?(day, open_sat)
    formated_day = day.strftime('%d-%m')

    if open_sat
      if day.on_weekday?
        OFFICIAL_HOLIDAYS.exclude?(formated_day) && day.on_weekday?
      else
        day.saturday?
      end
    else
      OFFICIAL_HOLIDAYS.exclude?(formated_day) && day.on_weekday?
    end
  end

  def search_link(current_search, total_count, path)
    tag.li(class: 'nav-item') do
      link_to "Busca: #{current_search} (#{total_count})",
              path,
              class: 'nav-link active',
              data: 'searchListTab'
    end
  end

  # rubocop:disable Metrics/ParameterLists
  def filter_tabs_links(current_filter:, total_count:, links:, filters:, i18n_scope:, path:)
    links.map do |key|
      filter = filters[key]
      active = filter == current_filter
      text = t("#{i18n_scope}.state.#{key}")
      text << " (#{total_count})" if active

      tag.li(class: 'nav-item') do
        link_to text, path.call(filter: filter), data: { cy: "#{filter}ListTab" },
                                                 class: "nav-link #{active && :active}"
      end
    end
  end
  # rubocop:enable Metrics/ParameterLists
end
