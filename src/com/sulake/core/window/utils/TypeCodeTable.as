package com.sulake.core.window.utils
{
   import com.sulake.core.window.enum.WindowType;
   import flash.utils.Dictionary;
   
   public class TypeCodeTable extends WindowType
   {
       
      
      public function TypeCodeTable()
      {
         super();
      }
      
      public static function fillTables(param1:Dictionary, param2:Dictionary = null) : void
      {
         var _loc3_:* = null;
         param1["background"] = const_940;
         param1["bitmap"] = const_861;
         param1["border"] = const_717;
         param1["border_notify"] = const_1700;
         param1["button"] = const_630;
         param1["button_thick"] = const_733;
         param1["button_icon"] = const_1781;
         param1["button_group_left"] = const_877;
         param1["button_group_center"] = const_775;
         param1["button_group_right"] = const_929;
         param1["canvas"] = const_883;
         param1["checkbox"] = const_934;
         param1["closebutton"] = const_1135;
         param1["container"] = const_394;
         param1["container_button"] = const_871;
         param1["display_object_wrapper"] = const_744;
         param1["dropmenu"] = const_503;
         param1["dropmenu_item"] = const_610;
         param1["frame"] = const_413;
         param1["frame_notify"] = const_1733;
         param1["header"] = const_923;
         param1["html"] = const_1138;
         param1["icon"] = const_1121;
         param1["itemgrid"] = const_1328;
         param1["itemgrid_horizontal"] = const_588;
         param1["itemgrid_vertical"] = const_754;
         param1["itemlist"] = const_1123;
         param1["itemlist_horizontal"] = const_429;
         param1["itemlist_vertical"] = const_392;
         param1["label"] = WINDOW_TYPE_LABEL;
         param1["maximizebox"] = const_1867;
         param1["menu"] = const_1825;
         param1["menu_item"] = const_1609;
         param1["submenu"] = const_1147;
         param1["minimizebox"] = const_1765;
         param1["notify"] = const_1684;
         param1["null"] = const_873;
         param1["password"] = const_760;
         param1["radiobutton"] = const_858;
         param1["region"] = const_528;
         param1["restorebox"] = const_1864;
         param1["scaler"] = const_600;
         param1["scaler_horizontal"] = const_1624;
         param1["scaler_vertical"] = const_1616;
         param1["scrollbar_horizontal"] = const_643;
         param1["scrollbar_vertical"] = const_938;
         param1["scrollbar_slider_button_up"] = const_1312;
         param1["scrollbar_slider_button_down"] = const_1269;
         param1["scrollbar_slider_button_left"] = const_1285;
         param1["scrollbar_slider_button_right"] = const_1153;
         param1["scrollbar_slider_bar_horizontal"] = const_1164;
         param1["scrollbar_slider_bar_vertical"] = const_1302;
         param1["scrollbar_slider_track_horizontal"] = const_1172;
         param1["scrollbar_slider_track_vertical"] = const_1183;
         param1["scrollable_itemlist"] = const_1734;
         param1["scrollable_itemlist_vertical"] = const_597;
         param1["scrollable_itemlist_horizontal"] = const_1109;
         param1["selector"] = const_787;
         param1["selector_list"] = const_731;
         param1["submenu"] = const_1147;
         param1["tab_button"] = const_879;
         param1["tab_container_button"] = const_1248;
         param1["tab_context"] = const_442;
         param1["tab_content"] = const_1225;
         param1["tab_selector"] = const_821;
         param1["text"] = const_594;
         param1["input"] = const_921;
         param1["toolbar"] = const_1844;
         param1["tooltip"] = const_417;
         if(param2 != null)
         {
            for(param2[param1[_loc3_]] in param1)
            {
            }
         }
      }
   }
}
