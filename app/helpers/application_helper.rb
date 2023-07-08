module ApplicationHelper

  def text_with_svg(svg_name, text, svg_start = 'first')
    if svg_start == 'first'
      "#{embedded_svg(svg_name, class: "settings-icon")}&nbsp;&nbsp;#{t(text)}".html_safe
    else
      "#{t(text)}&nbsp;&nbsp;#{embedded_svg(svg_name)}".html_safe
    end
	end

	def embedded_svg(filename, options = {})
    assets = Rails.application.assets
    asset = assets.find_asset(filename)

    if asset
      file = asset.source.force_encoding("UTF-8")
      doc = Nokogiri::HTML::DocumentFragment.parse file
      svg = doc.at_css "svg"
      svg["class"] = options[:class] if options[:class].present?
    else
      doc = "<!-- SVG #{filename} not found -->"
    end

    raw doc
  end

end
