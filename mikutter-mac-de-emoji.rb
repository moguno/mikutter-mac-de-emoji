# -*- coding: utf-8 -*-

# フォント定義
class Pango::FontDescription
  class << self
    alias :new_org :new

    def new(*args)
      tmp = new_org(*args)

      if UserConfig[:emoji_font]
        tmp.family += ",#{UserConfig[:emoji_font]}"
      end

      tmp
    end
  end
end


Plugin.create(:mikutter_mac_de_emoji) {

  # 良く知られている絵文字フォント
  @wellknown_emoji_fonts =  [
    "Apple カラー絵文字",
    "Segoe UI Symbol",
  ]


  # フォントの一覧を得る
  def get_font_list
    @tmp_widget ||= Gtk::VBox.new
    @tmp_widget.pango_context.families.map { |f| f.name }
  end


  # デフォルトの絵文字フォントを設定する
  if !UserConfig[:emoji_font]
    fonts = get_font_list

    # 良く知られているフォントが存在すればそれにする
    @wellknown_emoji_fonts.each { |font|
      if fonts.include?(font)
        UserConfig[:emoji_font] = font
        break
      end
    }
  end


  # 設定
  settings("絵文字") {
    fonts = {}

    get_font_list.each { |font| fonts[font] = font }

    select("絵文字フォント", :emoji_font, fonts) 
  }
}
