require 'octicons'

ADMONITION_TO_DATA = {
  note: {
    icon: "info",
    color: 0x1f6feb
  },
  tip: {
    icon: "light-bulb",
    color: 0x238636
  },
  important: {
    icon: "report",
    color: 0x8957e5
  },
  warning: {
    icon: "alert",
    color: 0x9e6a03
  },
  caution: {
    icon: "stop",
    color: 0xda3633
  }
}

ADMONITION = /(> \[\!(NOTE|TIP|IMPORTANT|WARNING|CAUTION)\] *((?:\n> .*)+))/

TEMPLATE = '''<div class="admonition" style="border-color: #%06x;" markdown="1">
  <p class="admonition-type" style="fill: #%06x;" markdown="1">%s %s</p>
  <p class="admonition-message" markdown="1">%s</p>
</div>'''

Jekyll::Hooks.register :pages, :pre_render do |page|
  if page.name[-3,3]==".md"
    Jekyll.logger.info "Processing #{page.name}..."
    content = page.content
    if content.match(ADMONITION)
      Jekyll.logger.info "Admonitions found... processing."
      matches = content.scan(ADMONITION)
      for full, admonition, admonition_content in matches do
        admonition_content.sub! '> ', ''
        admonition_content.gsub! '\n> ', '\n'
        content.sub! full, TEMPLATE % [
          ADMONITION_TO_DATA[admonition.downcase.to_sym][:color],
          ADMONITION_TO_DATA[admonition.downcase.to_sym][:color],
          Octicons::Octicon.new(ADMONITION_TO_DATA[admonition.downcase.to_sym][:icon]).to_svg,
          admonition.capitalize,
          admonition_content
        ]
      end
    else
      Jekyll.logger.debug "No admonitions found."
    page.content = content
    end
  else
    Jekyll.logger.debug "Not processing #{page.name}"
  end
end