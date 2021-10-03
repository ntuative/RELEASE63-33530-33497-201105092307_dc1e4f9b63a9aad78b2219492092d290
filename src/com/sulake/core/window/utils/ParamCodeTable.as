package com.sulake.core.window.utils
{
   import com.sulake.core.window.enum.WindowParam;
   import flash.utils.Dictionary;
   
   public class ParamCodeTable extends WindowParam
   {
       
      
      public function ParamCodeTable()
      {
         super();
      }
      
      public static function fillTables(param1:Dictionary, param2:Dictionary = null) : void
      {
         var _loc3_:* = null;
         param1["null"] = const_210;
         param1["bound_to_parent_rect"] = const_106;
         param1["child_window"] = const_1258;
         param1["embedded_controller"] = const_1190;
         param1["resize_to_accommodate_children"] = WINDOW_PARAM_RESIZE_TO_ACCOMMODATE_CHILDREN;
         param1["input_event_processor"] = const_31;
         param1["internal_event_handling"] = const_976;
         param1["mouse_dragging_target"] = const_250;
         param1["mouse_dragging_trigger"] = const_438;
         param1["mouse_scaling_target"] = const_362;
         param1["mouse_scaling_trigger"] = const_601;
         param1["horizontal_mouse_scaling_trigger"] = const_247;
         param1["vertical_mouse_scaling_trigger"] = const_260;
         param1["observe_parent_input_events"] = const_1255;
         param1["optimize_region_to_layout_size"] = const_593;
         param1["parent_window"] = const_1217;
         param1["relative_horizontal_scale_center"] = const_214;
         param1["relative_horizontal_scale_fixed"] = const_143;
         param1["relative_horizontal_scale_move"] = const_419;
         param1["relative_horizontal_scale_strech"] = const_426;
         param1["relative_scale_center"] = const_1174;
         param1["relative_scale_fixed"] = const_962;
         param1["relative_scale_move"] = const_1182;
         param1["relative_scale_strech"] = const_1305;
         param1["relative_vertical_scale_center"] = const_213;
         param1["relative_vertical_scale_fixed"] = const_167;
         param1["relative_vertical_scale_move"] = const_235;
         param1["relative_vertical_scale_strech"] = const_343;
         param1["on_resize_align_left"] = const_839;
         param1["on_resize_align_right"] = const_627;
         param1["on_resize_align_center"] = const_514;
         param1["on_resize_align_top"] = const_697;
         param1["on_resize_align_bottom"] = const_607;
         param1["on_resize_align_middle"] = const_486;
         param1["on_accommodate_align_left"] = const_1274;
         param1["on_accommodate_align_right"] = const_592;
         param1["on_accommodate_align_center"] = const_983;
         param1["on_accommodate_align_top"] = const_1287;
         param1["on_accommodate_align_bottom"] = const_581;
         param1["on_accommodate_align_middle"] = const_965;
         param1["route_input_events_to_parent"] = const_549;
         param1["use_parent_graphic_context"] = const_34;
         param1["draggable_with_mouse"] = const_1316;
         param1["scalable_with_mouse"] = const_1276;
         param1["reflect_horizontal_resize_to_parent"] = const_589;
         param1["reflect_vertical_resize_to_parent"] = const_513;
         param1["reflect_resize_to_parent"] = const_334;
         param1["force_clipping"] = WINDOW_PARAM_FORCE_CLIPPING;
         param1["inherit_caption"] = const_1301;
         if(param2 != null)
         {
            for(param2[param1[_loc3_]] in param1)
            {
            }
         }
      }
   }
}
