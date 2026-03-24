require_relative "../tool"
require_relative "../tools/select_tool"
require_relative "../tools/shape_tool"
require_relative "../tools/prefab_tool"

require_relative "../command"
require_relative "../commands/shape_command"
require_relative "../commands/polygon_point_command"
require_relative "../commands/prefab_command"

module IMICTDS
  module MapEditor
    class States
      class Editor < CyberarmEngine::GuiState
        attr_reader :active_item

        def setup
          theme(THEME)

          @editor_history = []

          @map = Map.new
          @map.edit_mode = true
          @map.offset = CyberarmEngine::Vector.new(
            @map.map_size / 2 - window.width / 2,
            @map.map_size / 2 - window.height / 2
          )

          @tool = Tool::SelectTool
          @active_item = nil

          # t = IMICTDS.milliseconds
          # @server = IMICTDS::Networking::Server.new(host: "localhost", port: 56789, channels: 8, map: nil, game_mode: :edit)
          # @client = IMICTDS::Networking::Client.new(host: "localhost", port: 56789, channels: 8)
          # @client.connect(0)

          flow(width: 1.0, height: 1.0) do
            # Left Panel
            stack(max_width: 384, width: 1.0, height: 1.0, background: 0xdd_b5835a, border_thickness_right: 2,
                  border_color: 0xaa_252525) do
              banner "Map Editor", width: 1.0, text_align: :center, margin_top: 32
              flow(width: 1.0, height: 40, border_thickness: 2, border_color: 0xaa_252525, margin_left: 32,
                   margin_right: 32, padding: 4) do
                button get_image("#{ROOT_PATH}/assets/ui_icons/exit.png"), image_height: 1.0, min_width: nil,
                                                                           tip: "Save map and close editor" do
                  # @client.disconnect(1_500)
                  # @server.close

                  pop_state
                end

                edit_line "MAP_NAME_HERE", fill: true, height: 1.0

                button get_image("#{ROOT_PATH}/assets/ui_icons/save.png"), image_height: 1.0, min_width: nil,
                                                                           tip: "Save map"
                button get_image("#{ROOT_PATH}/assets/ui_icons/right.png"), image_height: 1.0, min_width: nil,
                                                                            tip: "Test map"
              end

              stack(width: 1.0, fill: true, padding: 32, scroll: true) do
                flow(width: 1.0, height: 40, border_thickness: 2, border_color: 0xaa_252525, margin_bottom: 32,
                     padding: 4) do
                  title "Play Space", fill: true, tip: "Closed polygon defining the play area"
                  button get_image("#{ROOT_PATH}/assets/ui_icons/wrench.png"), image_height: 1.0, min_width: nil, tip: "Edit play space"
                  button get_image("#{ROOT_PATH}/assets/ui_icons/trashCan.png"), image_height: 1.0, min_width: nil, tip: "Delete play space and start over"
                end

                stack(width: 1.0, fill: true, border_thickness: 2, border_color: 0xaa_252525) do
                  flow(width: 1.0, height: 40, border_thickness_bottom: 2, border_color: 0xaa_252525, padding: 4) do
                    button "Shapes", fill: true, min_width: nil, tip: "Closed polygons that make up the play space" do
                      @editor_tree.clear { tree_shapes }
                    end

                    button "Prefabs", fill: true, min_width: nil, tip: "Reusable entity presets" do
                      @editor_tree.clear { tree_prefabs }
                    end

                    button "Entities", fill: true, min_width: nil, tip: "Placed prefabs" do
                      @editor_tree.clear { tree_entities }
                    end
                  end

                  @editor_tree = stack(width: 1.0, fill: true) do
                    tree_shapes
                  end
                end
              end
            end

            @map_area_container = flow(fill: true, height: 1.0, padding: 4) do
              @map_position_label = tagline "", width: 128
              @map_tool_label = tagline "Tool: #{@tool.name}"
            end

            # Right Panel: Editor Panel
            @editor_panel = stack(max_width: 384, width: 1.0, height: 1.0, background: 0xdd_b5835a, border_thickness_left: 2,
                  border_color: 0xaa_252525) do
              banner "Object Editor", width: 1.0, text_align: :center, margin_top: 32
              title "Prefab: 0xdeadbeef", width: 1.0, text_align: :center
              flow(width: 1.0, height: 40, border_thickness: 2, border_color: 0xaa_252525, margin_left: 32,
                   margin_right: 32, padding: 4) do
                edit_line "NAME", width: 1.0, tip: "Prefab name"
              end
              stack(width: 1.0, fill: true, padding: 32, scroll: true) do
                title "Components", width: 1.0, text_align: :center
                %w[Health Position Collider].each do |component|
                  subtitle component, width: 1.0, text_align: :center
                  flow(width: 1.0, height: 40, border_thickness: 2, border_color: 0xaa_252525, padding: 4) do
                    edit_line "#{rand(0..100)}", width: 1.0
                  end
                end
              end
            end
          end

          @polygon = Polygon.new(
            points: [
              CyberarmEngine::Vector.new(window.width / 2 - 100, window.height / 2 - 100),
              CyberarmEngine::Vector.new(window.width / 2, window.height / 2 - 100),
              CyberarmEngine::Vector.new(window.width / 2, window.height / 2 - 50),
              CyberarmEngine::Vector.new(window.width / 2 + 100, window.height / 2 - 50),
              CyberarmEngine::Vector.new(window.width / 2 + 100, window.height / 2 + 100),
              CyberarmEngine::Vector.new(window.width / 2 - 100, window.height / 2 - 100)
            ],
            z: 121,
            color: Gosu::Color.new(0xaa_aaaaaa),
            border_color: Gosu::Color::GREEN,
            border_thickness: 4
          )
        end

        def draw
          IMICTDS::MapRenderer.draw_map(@map, self)
          # IMICTDS::MapRenderer.draw_polygon(@polygon, self)
          # @polygon.draw

          # Gosu.flush

          # @enemy ||= get_image("#{ROOT_PATH}/assets/content/enemy.png")
          # @enemy.draw_rot(700, 400, 1000, 0, 0.5, 0.5, 1.0, 1.0, 0xff_aa2222)

          # @friend ||= get_image("#{ROOT_PATH}/assets/content/friend.png")
          # @friend.draw_rot(750, 400, 1000, 0, 0.5, 0.5, 1.0, 1.0, 0xff_1c71d8)

          # @bomb_platform ||= get_image("#{ROOT_PATH}/assets/content/bomb_platform.png")
          # @bomb_platform.draw_rot(800, 400, 1000, 0, 0.5, 0.5, 1.0, 1.0)

          # @bomb ||= get_image("#{ROOT_PATH}/assets/content/bomb.png")
          # @bomb.draw_rot(800, 400, 1000, 0, 0.5, 0.5, 1.0, 1.0)

          # @flag_platform ||= get_image("#{ROOT_PATH}/assets/content/flag_platform.png")
          # @flag_platform.draw_rot(850, 430, 1000, 0, 0.5, 0.5, 1.0, 1.0, 0xff_aa2222)

          # @flag ||= get_image("#{ROOT_PATH}/assets/content/enemy_flag.png")
          # @flag.draw_rot(875, 390, 1000, 0, 0.5, 0.5, 1.0, 1.0, 0xff_aa2222)

          # @flag_pole ||= get_image("#{ROOT_PATH}/assets/content/enemy_flag_pole.png")
          # @flag_pole.draw_rot(850, 400, 1000, 0, 0.5, 0.5, 1.0, 1.0)

          # @flag_platform ||= get_image("#{ROOT_PATH}/assets/content/flag_platform.png")
          # @flag_platform.draw_rot(850 + 75, 430, 1000, 0, 0.5, 0.5, 1.0, 1.0, 0xff_1c71d8)

          # @friend_flag ||= get_image("#{ROOT_PATH}/assets/content/friend_flag.png")
          # @friend_flag.draw_rot(875 + 75, 390, 1000, 0, 0.5, 0.5, 1.0, 1.0, 0xff_1c71d8)

          # @friend_flag_pole ||= get_image("#{ROOT_PATH}/assets/content/friend_flag_pole.png")
          # @friend_flag_pole.draw_rot(850 + 75, 400, 1000, 0, 0.5, 0.5, 1.0, 1.0)

          Gosu.flush

          super
        end

        def update
          # @server.think
          # @client.think

          if @map.drag_start
            delta = @map.drag_start - CyberarmEngine::Vector.new(window.mouse_x, window.mouse_y)

            @map.offset += delta

            @map.drag_start -= delta
          end

          @map_position_label.value = format("X: %0.2f\nY: %0.2f\nZoom: %0.2f", @map.offset.x, @map.offset.y, @map.zoom)

          super
        end

        def button_down(id)
          if @map_area_container.hit?(window.mouse_x, window.mouse_y)
            case id
            when Gosu::MS_WHEEL_UP
              @map.zoom += @map.zoom_step
              @map.zoom = @map.max_zoom if @map.zoom > @map.max_zoom
            when Gosu::MS_WHEEL_DOWN
              @map.zoom -= @map.zoom_step
              @map.zoom = @map.min_zoom if @map.zoom < @map.min_zoom
            when Gosu::MS_RIGHT
              if shift_down?
                @map.drag_start = CyberarmEngine::Vector.new(window.mouse_x, window.mouse_y)
              end
            when Gosu::MS_MIDDLE
              @map.drag_start = CyberarmEngine::Vector.new(window.mouse_x, window.mouse_y)
            when Gosu::KB_HOME
              @map.offset = CyberarmEngine::Vector.new(
                @map.map_size / 2 - window.width / 2,
                @map.map_size / 2 - window.height / 2
              )
            when Gosu::KB_ESCAPE
              set_tool(Tool::Select)
            end

            @tool.button_down(id, @map, self)
          end

          super
        end

        def button_up(id)
          if @map_area_container.hit?(window.mouse_x, window.mouse_y)
            case id
            when Gosu::MS_RIGHT
              if shift_down?
                @map.drag_start = nil
              end
            when Gosu::MS_MIDDLE
              @map.drag_start = nil
            end

            @tool.button_up(id, @map, self)
          end

          super
        end

        def set_tool(klass)
          @map_tool_label.value = "Tool: #{klass.name}"
          @tool = klass
        end

        def add_command(klass, hash = {})
          @editor_history << klass.new(hash)
        end

        def create_shape
          # wall clock time in seconds + runtime monotonic time
          shape_id = Time.now.utc.to_i + IMICTDS.milliseconds

          shape = Shape.new
          shape.id = shape_id
          shape.name = "UnnamedShape-#{shape_id}"

          @map.shapes << shape
          @active_item = shape

          add_command(Command::ShapeCommand, { id: shape.id, name: shape.name })
          pp @editor_history
          pp shape

          shape
        end

        def mouse_near?(x, y, dist)
          mouse_point = @map.transform_point(CyberarmEngine::Vector.new(window.mouse_x, window.mouse_y))

          return false unless @map_area_container.hit?(window.mouse_x, window.mouse_y)

          Gosu.distance(
            mouse_point.x,
            mouse_point.y,
            x,
            y
          ) <= dist
        end

        def tree_shapes
          flow(width: 1.0, height: 40, border_thickness_bottom: 2, border_color: 0xaa_252525, padding: 4) do
            para "Shapes: Designate the play space", fill: true
            button get_image("#{ROOT_PATH}/assets/ui_icons/plus.png"), image_height: 1.0, min_width: nil, tip: "Create shape" do
              set_tool(Tool::ShapeTool)
              shape = create_shape
              @editor_panel.clear { panel_shape(shape) }
            end
          end
          stack(width: 1.0, fill: true, scroll: true) do
            10.times do |i|
              flow(width: 1.0, height: 40, padding: 4) do
                background i.even? ? 0 : 0xaa_252525

                caption "0" * 32, fill: true, height: 1.0, text_wrap: :none, text_v_align: :center
                button get_image("#{ROOT_PATH}/assets/ui_icons/wrench.png"), image_height: 1.0, min_width: nil, tip: "Edit shape"
                button get_image("#{ROOT_PATH}/assets/ui_icons/trashCan.png"), image_height: 1.0, min_width: nil, tip: "Delete shape"
              end
            end
          end
        end

        def tree_prefabs
          flow(width: 1.0, height: 40, border_thickness_bottom: 2, border_color: 0xaa_252525, padding: 4) do
            para "Prefabs: Reusable entity presets", fill: true
            button get_image("#{ROOT_PATH}/assets/ui_icons/plus.png"), image_height: 1.0, min_width: nil, color: 0xff_252525, tip: "Create global prefab"
            button get_image("#{ROOT_PATH}/assets/ui_icons/plus.png"), image_height: 1.0, min_width: nil, tip: "Create map local prefab"
          end
          stack(width: 1.0, fill: true, scroll: true) do
            tagline "Global Prefabs", width: 1.0, border_thickness_top: 2, border_thickness_bottom: 2, border_color: 0xaa_252525, background: 0xaa_ff8800, text_align: :center
            10.times do |i|
              flow(width: 1.0, height: 40, padding: 4) do
                background i.even? ? 0 : 0xaa_252525

                caption ["Red Flag", "Blue Flag", "Bomb", "Red Spawn", "Blue Spawn"].sample, fill: true, height: 1.0, text_wrap: :none, text_v_align: :center
                button get_image("#{ROOT_PATH}/assets/ui_icons/wrench.png"), image_height: 1.0, min_width: nil, tip: "Edit prefab"
                button get_image("#{ROOT_PATH}/assets/ui_icons/trashCan.png"), image_height: 1.0, min_width: nil, tip: "Delete prefab"
              end
            end

            tagline "Map Local Prefabs", width: 1.0, border_thickness_top: 2, border_thickness_bottom: 2, border_color: 0xaa_252525, background: 0xaa_ff8800, text_align: :center
            10.times do |i|
              flow(width: 1.0, height: 40, padding: 4) do
                background i.even? ? 0 : 0xaa_252525

                caption ["Red Flag", "Blue Flag", "Bomb", "Red Spawn", "Blue Spawn"].sample, fill: true, height: 1.0, text_wrap: :none, text_v_align: :center
                button get_image("#{ROOT_PATH}/assets/ui_icons/wrench.png"), image_height: 1.0, min_width: nil, tip: "Edit prefab"
                button get_image("#{ROOT_PATH}/assets/ui_icons/trashCan.png"), image_height: 1.0, min_width: nil, tip: "Delete prefab"
              end
            end
          end
        end

        def tree_entities
          flow(width: 1.0, height: 40, border_thickness_bottom: 2, border_color: 0xaa_252525, padding: 4) do
            para "Entities: Placed prefabs", fill: true
            # button get_image("#{ROOT_PATH}/assets/ui_icons/plus.png"), image_height: 1.0, min_width: nil, tip: "Create shape"
          end
          stack(width: 1.0, fill: true, scroll: true) do
            10.times do |i|
              flow(width: 1.0, height: 40, padding: 4) do
                background i.even? ? 0 : 0xaa_252525

                caption ["Red Flag", "0xBlue Flag", "0xBomb", "0xRed Spawn", "0xBlue Spawn"].sample, fill: true, height: 1.0, text_wrap: :none, text_v_align: :center
                button get_image("#{ROOT_PATH}/assets/ui_icons/wrench.png"), image_height: 1.0, min_width: nil, tip: "Edit entity"
                button get_image("#{ROOT_PATH}/assets/ui_icons/trashCan.png"), image_height: 1.0, min_width: nil, tip: "Delete entity"
              end
            end
          end
        end

        def panel_shape(shape)
          banner "Shape Editor", width: 1.0, text_align: :center, margin_top: 32
          title "Shape: #{format("0x%010X", shape.id)}", width: 1.0, text_align: :center
          stack(width: 1.0, fill: true, border_thickness: 2, border_color: 0xaa_252525, margin: 32,
               margin_top: 0, padding: 4, scroll: true) do
            caption "Name", width: 1.0, text_align: :center
            edit_line shape.name, width: 1.0, tip: "Shape name"

            caption "Color", width: 1.0, text_align: :center
            list_box items: ["Red", "Green", "Blue"], width: 1.0

            caption "Layer", width: 1.0, text_align: :center
            list_box items: ["Background", "Ground", "Overlay"], width: 1.0

            caption "Collidable?", width: 1.0, text_align: :center
            toggle_button min_width: nil, image_height: 28
          end
        end

        def panel_prefab(prefab)
        end

        def panel_entity(entity)
        end
      end
    end
  end
end
