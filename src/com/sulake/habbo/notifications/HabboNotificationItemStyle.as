package com.sulake.habbo.notifications
{
   import com.sulake.core.utils.Map;
   import flash.display.BitmapData;
   
   public class HabboNotificationItemStyle
   {
       
      
      private var var_1797:Array;
      
      private var _icon:BitmapData;
      
      private var var_1798:Boolean;
      
      private var var_2440:String;
      
      public function HabboNotificationItemStyle(param1:Map, param2:BitmapData, param3:Boolean, param4:String)
      {
         super();
         if(param1 == null)
         {
            this.var_1797 = [];
            this._icon = null;
         }
         else
         {
            this.var_1797 = param1["uilinks"];
            this._icon = param1["icon"];
         }
         if(param2 != null)
         {
            this._icon = param2;
            this.var_1798 = param3;
         }
         else
         {
            this.var_1798 = false;
         }
         this.var_2440 = param4;
      }
      
      public function dispose() : void
      {
         if(this.var_1798 && this._icon != null)
         {
            this._icon.dispose();
            this._icon = null;
         }
      }
      
      public function get icon() : BitmapData
      {
         return this._icon;
      }
      
      public function get componentLinks() : Array
      {
         return this.var_1797;
      }
      
      public function get iconSrc() : String
      {
         return this.var_2440;
      }
   }
}
