# -*- coding: utf-8 -*-

module Pango
  class << self
    alias parse_markup_org parse_markup

    def parse_markup(text)
      emojied_text = text.gsub(/([\u{1F300}-\u{1F55B}]+)/) {
        "<span font_family=\"Apple カラー絵文字\">#{$1}</span>"
      }

      parse_markup_org(emojied_text)
    end
  end
end


Plugin.create(:mikutter_mac_de_emoji) {
}
