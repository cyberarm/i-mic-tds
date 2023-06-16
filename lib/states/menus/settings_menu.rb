module IMICTDS
  class States
    class SettingsMenu < Menu
      def menu_setup
        banner NAME, width: 1.0, text_align: :center

        title "Settings", width: 1.0, text_align: :center

        stack(width: 1.0, max_width: 900, border_thickness: 2, border_color: 0xaa_252525, fill: true, h_align: :center, scroll: true, padding: 4) do
          background 0xff_785651

          flow(width: 1.0, height: 648) do
            title "Accessibility", width: 214

            stack(fill: true, height: 1.0, margin_top: 36, padding: 4, border_thickness: 2, border_color: 0xaa_252525) do
              flow(width: 1.0, height: 40) do
                tagline "Font", width: 128
                @font_list = list_box items: ["NotoSans (Default)", "JetbrainsMono", "OpenDyslexic"], choose: "NotoSans (Default)", fill: true
              end
              @bold_font_example = tagline "The quick brown fox jumps over the lazy dog.", margin_left: 128 + 4
              @font_example = caption "The quick brown fox jumps over the lazy dog.", margin_left: 128 + 4

              @font_list.subscribe(:changed) do
                case @font_list.value.split(" ").first.strip.to_sym
                when :NotoSans
                  @bold_font_example.style.default[:font] = "#{ROOT_PATH}/assets/fonts/noto_sans/NotoSans-Black.ttf"
                  @font_example.style.default[:font] = "#{ROOT_PATH}/assets/fonts/noto_sans/NotoSans-Bold.ttf"
                when :JetbrainsMono
                  @bold_font_example.style.default[:font] = "#{ROOT_PATH}/assets/fonts/jetbrains_mono/JetbrainsMono-ExtraBold.ttf"
                  @font_example.style.default[:font] = "#{ROOT_PATH}/assets/fonts/jetbrains_mono/JetbrainsMono-Bold.ttf"
                when :OpenDyslexic
                  @bold_font_example.style.default[:font] = "#{ROOT_PATH}/assets/fonts/open_dyslexic/OpenDyslexic-Bold.otf"
                  @font_example.style.default[:font] = "#{ROOT_PATH}/assets/fonts/open_dyslexic/OpenDyslexic-Regular.otf"
                end

                @bold_font_example.style.font = @bold_font_example.style.default[:font]
                @font_example.style.font = @font_example.style.default[:font]

                # FIXME: Update THEME and purge non-game, non-dialog states
                # TODO: Do this properly, in its own method.
                THEME[:Banner][:font] = @bold_font_example.style.font
                THEME[:Title][:font] = @bold_font_example.style.font
                THEME[:Tagline][:font] = @bold_font_example.style.font
                THEME[:Button][:font] = @bold_font_example.style.font
                THEME[:TextBlock][:font] = @font_example.style.font
              end

              tagline "Friendly Team Color", margin_top: 16
              stack(width: 1.0, fill: true, margin_left: 32, padding: 4, border_thickness: 2, border_color: 0xaa_252525) do
                flow(width: 1.0, fill: true) do
                  caption "Hue/Color", width: 160
                  @friendly_team_color_hue = slider value: 213.00, range: 0.0..360.0, step: 0.01, fill: true
                end
                flow(width: 1.0, fill: true) do
                  caption "Saturation", width: 160
                  @friendly_team_color_saturation = slider value: 0.85, range: 0.0..1.0, step: 0.01, fill: true
                end
                flow(width: 1.0, fill: true) do
                  caption "Value/Lightness", width: 160
                  @friendly_team_color_value = slider value: 0.70, range: 0.0..1.0, step: 0.01, fill: true
                end

                @friendly_team_color_label = tagline "Friendly Player Name", text_border: true, text_border_size: 1, text_border_color: 0xff_000000, margin_top: 8

                [@friendly_team_color_hue, @friendly_team_color_saturation, @friendly_team_color_value].each do |element|
                  element.subscribe(:changed) do
                    color = Gosu::Color.from_hsv(@friendly_team_color_hue.value, @friendly_team_color_saturation.value, @friendly_team_color_value.value)
                    @friendly_team_color_label.style.default[:color] = color
                    @friendly_team_color_label.style.color = color
                    request_recalculate_for(@friendly_team_color_label)
                  end
                end

                @friendly_team_color_hue.value = 213.0
                @friendly_team_color_saturation.value = 0.85
                @friendly_team_color_value.value = 0.70
              end

              tagline "Enemy Team Color", margin_top: 16
              stack(width: 1.0, fill: true, margin_left: 32, padding: 4, border_thickness: 2, border_color: 0xaa_252525) do
                flow(width: 1.0, fill: true) do
                  caption "Hue/Color", width: 160
                  @enemy_team_color_hue = slider value: 360.0, range: 0.0..360.0, step: 0.1, fill: true
                end
                flow(width: 1.0, fill: true) do
                  caption "Saturation", width: 160
                  @enemy_team_color_saturation = slider value: 0.5, range: 0.0..1.0, step: 0.1, fill: true
                end
                flow(width: 1.0, fill: true) do
                  caption "Value/Lightness", width: 160
                  @enemy_team_color_value = slider value: 1.0, range: 0.0..1.0, step: 0.1, fill: true
                end


                @enemy_team_color_label = tagline "Enemy Player Name", text_border: true, text_border_size: 1, text_border_color: 0xff_000000, margin_top: 8

                [@enemy_team_color_hue, @enemy_team_color_saturation, @enemy_team_color_value].each do |element|
                  element.subscribe(:changed) do
                    color = Gosu::Color.from_hsv(@enemy_team_color_hue.value, @enemy_team_color_saturation.value, @enemy_team_color_value.value)
                    @enemy_team_color_label.style.default[:color] = color
                    @enemy_team_color_label.style.color = color
                    request_recalculate_for(@enemy_team_color_label)
                  end
                end

                @enemy_team_color_hue.value = 10.0
                @enemy_team_color_saturation.value = 0.98
                @enemy_team_color_value.value = 0.64
              end
            end
          end

          flow(width: 1.0, height: 96, margin_top: 32) do
            title "Video", width: 214

            stack(fill: true, height: 1.0, margin_top: 36, padding: 4, border_thickness: 2, border_color: 0xaa_252525) do
              flow(width: 1.0, fill: true) do
                tagline "Update Rate", width: 192
                list_box items: ["Unlimited", "60", "30"], choose: "60", fill: true
              end
            end
          end

          flow(width: 1.0, height: 256, margin_top: 32) do
            title "Audio", width: 214

            stack(fill: true, height: 1.0, margin_top: 36, padding: 4, border_thickness: 2, border_color: 0xaa_252525) do
              flow(width: 1.0, fill: true) do
                tagline "Master Volume", width: 192
                slider value: 1.0, range: 0.0..1.0, step: 0.1, fill: true
              end
              flow(width: 1.0, fill: true) do
                tagline "Music Volume", width: 192
                slider value: 0.5, range: 0.0..1.0, step: 0.1, fill: true
              end
              flow(width: 1.0, fill: true) do
                tagline "SFX Volume", width: 192
                slider value: 1.0, range: 0.0..1.0, step: 0.1, fill: true
              end
              flow(width: 1.0, fill: true) do
                tagline "Ambient Volume", width: 192
                slider value: 0.25, range: 0.0..1.0, step: 0.1, fill: true
              end
            end
          end

          flow(width: 1.0, height: 156, margin_top: 32) do
            title "Network", width: 214

            stack(fill: true, height: 1.0, margin_top: 36, padding: 4, border_thickness: 2, border_color: 0xaa_252525) do
              flow(width: 1.0, fill: true) do
                tagline "Client Interface", width: 192
                list_box items: ["ANY"], fill: true
              end
              flow(width: 1.0, fill: true) do
                tagline "Server Interface", width: 192
                list_box items: ["ANY"], fill: true
              end
            end
          end
        end

        flow(width: 1.0, max_width: 900, height: 40, padding: 4, h_align: :center) do
          button "BACK", height: 1.0 do
            pop_state
          end
        end
      end
    end
  end
end
