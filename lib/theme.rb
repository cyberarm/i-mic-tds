module IMICTDS
  THEME = {
    TextBlock: {
      text_static: true,
      font: "#{ROOT_PATH}/assets/fonts/noto_sans/NotoSans-Bold.ttf"
    },
    Banner: {
      font: "#{ROOT_PATH}/assets/fonts/noto_sans/NotoSans-Black.ttf"
    },
    Title: {
      font: "#{ROOT_PATH}/assets/fonts/noto_sans/NotoSans-Black.ttf"
    },
    Tagline: {
      font: "#{ROOT_PATH}/assets/fonts/noto_sans/NotoSans-Black.ttf"
    },
    ToolTip: {
      text_size: 24
    },
    Button: {
      text_static: true,
      text_size: 24,
      font: "#{ROOT_PATH}/assets/fonts/noto_sans/NotoSans-Black.ttf",
      min_width: 128
    },
    ToggleButton: {
      checkmark_image: "#{ROOT_PATH}/assets/ui_icons/checkmark.png",
      image_height: 1.0,
      height: 1.0,
      min_width: nil
    }
  }
end
