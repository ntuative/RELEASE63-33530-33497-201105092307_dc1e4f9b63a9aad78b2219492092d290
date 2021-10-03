package com.sulake.core.utils
{
   import flash.text.Font;
   import flash.utils.getQualifiedClassName;
   
   public class FontEnum
   {
      
      private static const const_654:Map = new Map();
      
      private static const const_367:Map = new Map();
      
      private static var var_1104:Boolean = false;
      
      {
         init();
      }
      
      public function FontEnum()
      {
         super();
      }
      
      public static function isSystemFont(param1:String) : Boolean
      {
         return const_654.getValue(param1) != null;
      }
      
      public static function isEmbeddedFont(param1:String) : Boolean
      {
         return const_367.getValue(param1) != null;
      }
      
      public static function get systemFonts() : Map
      {
         return const_654;
      }
      
      public static function get embeddedFonts() : Map
      {
         return const_367;
      }
      
      public static function registerFont(param1:Class) : Font
      {
         var _loc4_:* = null;
         Font.registerFont(param1 as Class);
         var _loc2_:String = getQualifiedClassName(param1);
         var _loc3_:Array = Font.enumerateFonts(false);
         var _loc5_:int = _loc3_.length;
         var _loc6_:int = _loc5_;
         while(_loc6_ > 0)
         {
            _loc4_ = _loc3_[_loc6_ - 1];
            if(getQualifiedClassName(_loc4_) == _loc2_)
            {
               break;
            }
            _loc6_--;
         }
         const_367.add(_loc4_.fontName,_loc4_);
         return _loc4_;
      }
      
      private static function init() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(!var_1104)
         {
            _loc1_ = Font.enumerateFonts(true);
            _loc2_ = Font.enumerateFonts(false);
            for each(_loc3_ in _loc1_)
            {
               if(_loc2_.indexOf(_loc3_) == -1)
               {
                  const_654.add(_loc3_.fontName,_loc3_);
               }
            }
            var_1104 = true;
         }
      }
      
      public static function refresh() : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc1_:Array = Font.enumerateFonts(false);
         var _loc4_:int = _loc1_.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc2_ = _loc1_[_loc5_];
            _loc3_ = const_367.getValue(_loc2_.fontName);
            if(!_loc3_ || _loc3_.fontType != _loc2_.fontType || _loc3_.fontStyle != _loc2_.fontStyle)
            {
               const_367.add(_loc2_.fontName,_loc2_);
            }
            _loc5_++;
         }
      }
   }
}
