package com.sulake.core.window.utils
{
   import com.sulake.core.utils.Map;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getQualifiedClassName;
   
   public class PropertyStruct
   {
      
      public static const const_159:String = "hex";
      
      public static const const_43:String = "int";
      
      public static const const_285:String = "uint";
      
      public static const const_134:String = "Number";
      
      public static const const_39:String = "Boolean";
      
      public static const const_54:String = "String";
      
      public static const const_293:String = "Point";
      
      public static const const_237:String = "Rectangle";
      
      public static const const_168:String = "Array";
      
      public static const const_246:String = "Map";
       
      
      private var var_607:String;
      
      private var var_178:Object;
      
      private var _type:String;
      
      private var var_2352:Boolean;
      
      private var var_2925:Boolean;
      
      private var var_2353:Array;
      
      public function PropertyStruct(param1:String, param2:Object, param3:String, param4:Boolean, param5:Array = null)
      {
         super();
         this.var_607 = param1;
         this.var_178 = param2;
         this._type = param3;
         this.var_2352 = param4;
         this.var_2925 = param3 == const_246 || param3 == const_168 || param3 == const_293 || param3 == const_237;
         this.var_2353 = param5;
      }
      
      public function get key() : String
      {
         return this.var_607;
      }
      
      public function get value() : Object
      {
         return this.var_178;
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function get valid() : Boolean
      {
         return this.var_2352;
      }
      
      public function get range() : Array
      {
         return this.var_2353;
      }
      
      public function toString() : String
      {
         switch(this._type)
         {
            case const_159:
               return "0x" + uint(this.var_178).toString(16);
            case const_39:
               return Boolean(this.var_178) == true ? "true" : "false";
            case const_293:
               return "Point(" + Point(this.var_178).x + ", " + Point(this.var_178).y + ")";
            case const_237:
               return "Rectangle(" + Rectangle(this.var_178).x + ", " + Rectangle(this.var_178).y + ", " + Rectangle(this.var_178).width + ", " + Rectangle(this.var_178).height + ")";
            default:
               return String(this.value);
         }
      }
      
      public function toXMLString() : String
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         switch(this._type)
         {
            case const_246:
               _loc3_ = this.var_178 as Map;
               _loc1_ = "<var key=\"" + this.var_607 + "\">\r<value>\r<" + this._type + ">\r";
               _loc2_ = 0;
               while(_loc2_ < _loc3_.length)
               {
                  _loc1_ += "<var key=\"" + _loc3_.getKey(_loc2_) + "\" value=\"" + _loc3_.getWithIndex(_loc2_) + "\" type=\"" + getQualifiedClassName(_loc3_.getWithIndex(_loc2_)) + "\" />\r";
                  _loc2_++;
               }
               _loc1_ += "</" + this._type + ">\r</value>\r</var>";
               break;
            case const_168:
               _loc4_ = this.var_178 as Array;
               _loc1_ = "<var key=\"" + this.var_607 + "\">\r<value>\r<" + this._type + ">\r";
               _loc2_ = 0;
               while(_loc2_ < _loc4_.length)
               {
                  _loc1_ += "<var key=\"" + String(_loc2_) + "\" value=\"" + _loc4_[_loc2_] + "\" type=\"" + getQualifiedClassName(_loc4_[_loc2_]) + "\" />\r";
                  _loc2_++;
               }
               _loc1_ += "</" + this._type + ">\r</value>\r</var>";
               break;
            case const_293:
               _loc5_ = this.var_178 as Point;
               _loc1_ = "<var key=\"" + this.var_607 + "\">\r<value>\r<" + this._type + ">\r";
               _loc1_ += "<var key=\"x\" value=\"" + _loc5_.x + "\" type=\"" + const_43 + "\" />\r";
               _loc1_ += "<var key=\"y\" value=\"" + _loc5_.y + "\" type=\"" + const_43 + "\" />\r";
               _loc1_ += "</" + this._type + ">\r</value>\r</var>";
               break;
            case const_237:
               _loc6_ = this.var_178 as Rectangle;
               _loc1_ = "<var key=\"" + this.var_607 + "\">\r<value>\r<" + this._type + ">\r";
               _loc1_ += "<var key=\"x\" value=\"" + _loc6_.x + "\" type=\"" + const_43 + "\" />\r";
               _loc1_ += "<var key=\"y\" value=\"" + _loc6_.y + "\" type=\"" + const_43 + "\" />\r";
               _loc1_ += "<var key=\"width\" value=\"" + _loc6_.width + "\" type=\"" + const_43 + "\" />\r";
               _loc1_ += "<var key=\"height\" value=\"" + _loc6_.height + "\" type=\"" + const_43 + "\" />\r";
               _loc1_ += "</" + this._type + ">\r</value>\r</var>";
               break;
            case const_159:
               _loc1_ = "<var key=\"" + this.var_607 + "\" value=\"" + "0x" + uint(this.var_178).toString(16) + "\" type=\"" + this._type + "\" />";
               break;
            default:
               _loc1_ = "<var key=\"" + this.var_607 + "\" value=\"" + this.var_178 + "\" type=\"" + this._type + "\" />";
         }
         return _loc1_;
      }
   }
}
