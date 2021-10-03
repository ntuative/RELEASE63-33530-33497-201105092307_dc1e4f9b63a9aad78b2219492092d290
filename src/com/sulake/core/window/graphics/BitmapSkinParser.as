package com.sulake.core.window.graphics
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.utils.Map;
   import com.sulake.core.utils.XMLVariableParser;
   import com.sulake.core.window.enum.WindowState;
   import com.sulake.core.window.graphics.renderer.BitmapSkinTemplate;
   import com.sulake.core.window.graphics.renderer.BitmapSkinTemplateEntity;
   import com.sulake.core.window.graphics.renderer.ISkinLayout;
   import com.sulake.core.window.graphics.renderer.ISkinRenderer;
   import com.sulake.core.window.graphics.renderer.SkinLayout;
   import com.sulake.core.window.graphics.renderer.SkinLayoutEntity;
   import com.sulake.core.window.utils.ChildEntityArray;
   import com.sulake.core.window.utils.IChildEntityArray;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class BitmapSkinParser
   {
      
      public static const const_104:String = "default";
      
      public static const const_88:String = "active";
      
      public static const const_89:String = "focused";
      
      public static const const_87:String = "hovering";
      
      public static const const_53:String = "selected";
      
      public static const const_95:String = "pressed";
      
      public static const const_86:String = "disabled";
      
      public static const const_72:String = "locked";
       
      
      public function BitmapSkinParser()
      {
         super();
      }
      
      public static function parseSkinDescription(param1:XML, param2:XMLList, param3:ISkinRenderer, param4:String, param5:IAssetLibrary) : void
      {
         var _loc12_:* = null;
         var _loc13_:* = null;
         var _loc14_:* = null;
         var _loc15_:* = 0;
         var _loc16_:int = 0;
         var _loc17_:* = null;
         var _loc18_:* = null;
         var _loc19_:* = 0;
         var _loc20_:int = 0;
         var _loc21_:int = 0;
         var _loc22_:* = null;
         var _loc6_:Map = new Map();
         var _loc7_:XMLList = param1.child("variables");
         if(_loc7_.length() > 0)
         {
            _loc12_ = _loc7_[0];
            _loc13_ = _loc12_.child("variable");
            if(_loc13_.length())
            {
               XMLVariableParser.parseVariableList(_loc13_,_loc6_);
            }
         }
         var _loc8_:Dictionary = new Dictionary();
         var _loc9_:XMLList = param1.child("templates");
         if(_loc9_[0])
         {
            parseTemplateList(param3,_loc9_[0],_loc8_,_loc6_,param5);
         }
         var _loc10_:Dictionary = new Dictionary();
         var _loc11_:XMLList = param1.child("layouts");
         if(_loc11_[0])
         {
            if(param4 == null)
            {
               method_4(param3,_loc11_[0],_loc10_,_loc6_);
            }
            else
            {
               _loc14_ = _loc11_[0].child("layout");
               _loc15_ = uint(_loc14_.length());
               _loc16_ = 0;
               while(_loc16_ < _loc15_)
               {
                  _loc17_ = _loc14_[_loc16_];
                  if(_loc17_.attribute("name") == param4)
                  {
                     parseLayout(param3,_loc17_,_loc10_,_loc6_);
                     break;
                  }
                  _loc16_++;
               }
            }
         }
         if(param2.length() == 0)
         {
            param2 = param1.child("states");
         }
         if(param2.length() > 0)
         {
            if(param4 == null)
            {
               parseRenderStateList(param3,param2[0],_loc10_,_loc6_);
            }
            else
            {
               _loc18_ = param2[0].child("state");
               _loc19_ = uint(_loc18_.length());
               _loc20_ = 0;
               _loc21_ = 0;
               while(_loc21_ < _loc19_)
               {
                  _loc22_ = _loc18_[_loc21_];
                  if(_loc22_.attribute("layout") == param4)
                  {
                     parseState(param3,_loc22_,_loc10_,_loc6_);
                     _loc20_++;
                  }
                  _loc21_++;
               }
            }
         }
      }
      
      protected static function parseLayout(param1:ISkinRenderer, param2:XML, param3:Dictionary, param4:Map) : void
      {
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc5_:String = param2.attribute("name");
         var _loc6_:* = param2.attribute("transparent") == "true";
         var _loc7_:IChildEntityArray = new ChildEntityArray();
         var _loc8_:String = param2.attribute("blendMode");
         var _loc9_:SkinLayout = new SkinLayout(_loc5_,_loc6_,_loc8_,_loc7_);
         var _loc10_:XMLList = param2.child("entities");
         if(_loc10_.length() > 0)
         {
            _loc11_ = _loc10_[0];
            _loc12_ = _loc11_.child("entity");
            if(_loc12_.length())
            {
               parseLayoutEntityList(param1,_loc9_,_loc12_,param4);
            }
         }
         param3[_loc5_] = _loc9_;
         param1.addLayout(_loc9_);
      }
      
      protected static function method_4(param1:ISkinRenderer, param2:XML, param3:Dictionary, param4:Map) : void
      {
         var _loc8_:* = null;
         var _loc5_:XMLList = param2.child("layout");
         var _loc6_:uint = _loc5_.length();
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_)
         {
            _loc8_ = _loc5_[_loc7_];
            parseLayout(param1,_loc8_,param3,param4);
            _loc7_++;
         }
      }
      
      protected static function parseLayoutEntity(param1:XML, param2:Map) : SkinLayoutEntity
      {
         var _loc3_:* = 0;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         _loc6_ = param1.attribute("id");
         _loc3_ = uint(_loc6_ == null ? 0 : uint(uint(_loc6_)));
         _loc6_ = param1.attribute("name");
         _loc4_ = _loc6_ == null ? "" : _loc6_;
         _loc5_ = new SkinLayoutEntity(_loc3_,_loc4_);
         _loc6_ = param1.attribute("colorize");
         _loc5_.colorize = _loc6_ == "" ? true : _loc6_ == "true";
         _loc6_ = null;
         _loc8_ = param1.child("color");
         if(_loc8_.length() > 0)
         {
            _loc7_ = _loc8_[0];
            _loc6_ = String(_loc7_);
            if(_loc6_ != null)
            {
               if(_loc6_.charAt(0) == "$")
               {
                  _loc6_ = param2[_loc6_.slice(1,_loc6_.length)];
               }
            }
         }
         _loc5_.color = _loc6_ == null ? 0 : uint(uint(_loc6_));
         _loc6_ = null;
         _loc8_ = param1.child("blend");
         if(_loc8_.length() > 0)
         {
            _loc7_ = _loc8_[0];
            _loc6_ = String(_loc7_);
            if(_loc6_ != null)
            {
               if(_loc6_.charAt(0) == "$")
               {
                  _loc6_ = param2[_loc6_.slice(1,_loc6_.length)];
               }
            }
         }
         _loc5_.blend = _loc6_ == null ? 4294967295 : uint(uint(_loc6_));
         _loc8_ = param1.child("scale");
         if(_loc8_.length() > 0)
         {
            _loc7_ = _loc8_[0];
            _loc6_ = _loc7_.attribute("horizontal");
            if(_loc6_ != null)
            {
               if(_loc6_.charAt(0) == "$")
               {
                  _loc6_ = param2[_loc6_.slice(1,_loc6_.length)];
               }
            }
            switch(_loc6_.toLowerCase())
            {
               case "fixed":
                  _loc5_.var_401 = SkinLayoutEntity.const_576;
                  break;
               case "move":
                  _loc5_.var_401 = SkinLayoutEntity.const_302;
                  break;
               case "strech":
                  _loc5_.var_401 = SkinLayoutEntity.const_554;
                  break;
               case "tiled":
                  _loc5_.var_401 = SkinLayoutEntity.const_303;
                  break;
               case "center":
                  _loc5_.var_401 = SkinLayoutEntity.const_1231;
            }
            _loc6_ = _loc7_.attribute("vertical");
            if(_loc6_ != null)
            {
               if(_loc6_.charAt(0) == "$")
               {
                  _loc6_ = param2[_loc6_.slice(1,_loc6_.length)];
               }
            }
            switch(_loc6_.toLowerCase())
            {
               case "fixed":
                  _loc5_.var_399 = SkinLayoutEntity.const_576;
                  break;
               case "move":
                  _loc5_.var_399 = SkinLayoutEntity.const_302;
                  break;
               case "strech":
                  _loc5_.var_399 = SkinLayoutEntity.const_554;
                  break;
               case "tiled":
                  _loc5_.var_399 = SkinLayoutEntity.const_303;
                  break;
               case "center":
                  _loc5_.var_399 = SkinLayoutEntity.const_1231;
            }
         }
         _loc8_ = param1.child("region");
         if(_loc8_.length() > 0)
         {
            _loc7_ = _loc8_[0];
            _loc8_ = _loc7_.child("Rectangle");
            _loc7_ = _loc8_[0];
            _loc5_.region = new Rectangle();
            _loc6_ = _loc7_.attribute("x");
            _loc5_.region.x = Number(_loc6_.charAt(0) == "$" ? param2[_loc6_.slice(1,_loc6_.length)] : _loc6_);
            _loc6_ = _loc7_.attribute("y");
            _loc5_.region.y = Number(_loc6_.charAt(0) == "$" ? param2[_loc6_.slice(1,_loc6_.length)] : _loc6_);
            _loc6_ = _loc7_.attribute("width");
            _loc5_.region.width = Number(_loc6_.charAt(0) == "$" ? param2[_loc6_.slice(1,_loc6_.length)] : _loc6_);
            _loc6_ = _loc7_.attribute("height");
            _loc5_.region.height = Number(_loc6_.charAt(0) == "$" ? param2[_loc6_.slice(1,_loc6_.length)] : _loc6_);
         }
         return _loc5_;
      }
      
      protected static function parseLayoutEntityList(param1:ISkinRenderer, param2:SkinLayout, param3:XMLList, param4:Map) : void
      {
         var _loc5_:* = null;
         var _loc6_:int = 0;
         var _loc7_:uint = param3.length();
         _loc6_ = 0;
         while(_loc6_ < _loc7_)
         {
            _loc5_ = parseLayoutEntity(param3[_loc6_],param4);
            if(_loc5_ != null)
            {
               param2.addChild(_loc5_);
            }
            _loc6_++;
         }
      }
      
      protected static function parseTemplateList(param1:ISkinRenderer, param2:XML, param3:Dictionary, param4:Map, param5:IAssetLibrary) : void
      {
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc13_:* = null;
         var _loc14_:* = null;
         var _loc15_:* = null;
         var _loc6_:XMLList = param2.child("template");
         var _loc7_:uint = _loc6_.length();
         var _loc8_:int = 0;
         while(_loc8_ < _loc7_)
         {
            _loc9_ = _loc6_[_loc8_];
            _loc10_ = _loc9_.attribute("name");
            if(_loc10_ != null)
            {
               if(_loc10_.charAt(0) == "$")
               {
                  _loc10_ = param4[_loc10_.slice(1,_loc10_.length)];
               }
            }
            _loc11_ = _loc9_.attribute("asset");
            if(_loc11_ != null)
            {
               if(_loc11_.charAt(0) == "$")
               {
                  _loc11_ = param4[_loc11_.slice(1,_loc11_.length)];
               }
            }
            _loc12_ = new BitmapSkinTemplate(_loc10_,param5.getAssetByName(_loc11_));
            _loc13_ = _loc9_.child("entities");
            if(_loc13_.length() > 0)
            {
               _loc14_ = _loc13_[0];
               _loc15_ = _loc14_.child("entity");
               if(_loc15_.length())
               {
                  parseTemplateEntityList(param1,_loc12_,_loc15_,param4);
               }
            }
            param3[_loc10_] = _loc12_;
            param1.addTemplate(_loc12_);
            _loc8_++;
         }
      }
      
      protected static function parseTemplateEntityList(param1:ISkinRenderer, param2:BitmapSkinTemplate, param3:XMLList, param4:Map) : void
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc13_:* = 0;
         var _loc14_:* = null;
         var _loc16_:int = 0;
         var _loc15_:int = param3.length();
         _loc16_ = 0;
         while(_loc16_ < _loc15_)
         {
            _loc5_ = param3[_loc16_];
            _loc10_ = _loc5_.attribute("name");
            _loc11_ = _loc10_.charAt(0) == "$" ? param4[_loc10_.slice(1,_loc10_.length)] : _loc10_;
            _loc10_ = _loc5_.attribute("type");
            _loc12_ = _loc10_.charAt(0) == "$" ? param4[_loc10_.slice(1,_loc10_.length)] : _loc10_;
            _loc10_ = _loc5_.attribute("id");
            _loc13_ = uint(uint(_loc10_.charAt(0) == "$" ? param4[_loc10_.slice(1,_loc10_.length)] : _loc10_));
            _loc6_ = _loc5_.child("region");
            if(_loc6_.length() > 0)
            {
               _loc7_ = _loc6_[0];
               _loc6_ = _loc7_.child("Rectangle");
               _loc7_ = _loc6_[0];
               _loc14_ = new Rectangle();
               _loc10_ = _loc7_.attribute("x");
               _loc14_.x = Number(_loc10_.charAt(0) == "$" ? param4[_loc10_.slice(1,_loc10_.length)] : _loc10_);
               _loc10_ = _loc7_.attribute("y");
               _loc14_.y = Number(_loc10_.charAt(0) == "$" ? param4[_loc10_.slice(1,_loc10_.length)] : _loc10_);
               _loc10_ = _loc7_.attribute("width");
               _loc14_.width = Number(_loc10_.charAt(0) == "$" ? param4[_loc10_.slice(1,_loc10_.length)] : _loc10_);
               _loc10_ = _loc7_.attribute("height");
               _loc14_.height = Number(_loc10_.charAt(0) == "$" ? param4[_loc10_.slice(1,_loc10_.length)] : _loc10_);
            }
            _loc8_ = _loc5_.child("variables");
            if(_loc8_.length() > 0)
            {
               _loc9_ = _loc8_[0];
               _loc8_ = _loc9_.child("variable");
               param4 = new Map();
               XMLVariableParser.parseVariableList(_loc8_,param4);
            }
            param2.addChild(new BitmapSkinTemplateEntity(_loc11_,_loc12_,_loc13_,_loc14_,param4));
            _loc16_++;
         }
      }
      
      protected static function parseState(param1:ISkinRenderer, param2:XML, param3:Dictionary, param4:Map) : void
      {
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc13_:* = null;
         var _loc14_:* = null;
         var _loc15_:* = null;
         var _loc5_:String = param2.attribute("name");
         if(_loc5_.charAt(0) == "$")
         {
            _loc5_ = param4[_loc5_.slice(1,_loc5_.length)];
         }
         var _loc6_:String = param2.attribute("layout");
         if(_loc6_.charAt(0) == "$")
         {
            _loc6_ = param4[_loc6_.slice(1,_loc6_.length)];
         }
         var _loc7_:String = param2.attribute("template");
         if(_loc7_.charAt(0) == "$")
         {
            _loc7_ = param4[_loc7_.slice(1,_loc7_.length)];
         }
         var _loc8_:ISkinLayout = param3[_loc6_];
         if(_loc8_ == null)
         {
            throw new Error("State " + _loc5_ + " has invalid layout reference " + _loc6_ + "!");
         }
         var _loc9_:XMLList = param2.child("variables");
         if(_loc9_.length() > 0)
         {
            _loc11_ = _loc9_[0];
            _loc12_ = _loc11_.child("variable");
            if(_loc12_.length())
            {
               _loc13_ = new Map();
               XMLVariableParser.parseVariableList(_loc12_,_loc13_);
               for(_loc14_ in _loc13_)
               {
                  _loc15_ = _loc13_[_loc14_];
                  if(_loc15_ is String)
                  {
                     if(String(_loc15_).charAt(0) == "$")
                     {
                        _loc15_ = param4[_loc15_.slice(1,_loc15_.length)];
                        _loc13_[_loc14_] = _loc15_;
                     }
                  }
               }
            }
         }
         var _loc10_:int = 0;
         switch(_loc5_)
         {
            case BitmapSkinParser.const_88:
               _loc10_ = 0;
               break;
            case BitmapSkinParser.const_104:
               _loc10_ = 0;
               break;
            case BitmapSkinParser.const_89:
               _loc10_ = 0;
               break;
            case BitmapSkinParser.const_86:
               _loc10_ = 0;
               break;
            case BitmapSkinParser.const_87:
               _loc10_ = 0;
               break;
            case BitmapSkinParser.const_95:
               _loc10_ = 0;
               break;
            case BitmapSkinParser.const_53:
               _loc10_ = 0;
               break;
            case BitmapSkinParser.const_72:
               _loc10_ = 0;
               break;
            default:
               throw new Error("Unknown window state: \"" + _loc5_ + "\"!");
         }
         param1.registerLayoutForRenderState(_loc10_,_loc6_);
         param1.registerTemplateForRenderState(_loc10_,_loc7_);
      }
      
      protected static function parseRenderStateList(param1:ISkinRenderer, param2:XML, param3:Dictionary, param4:Map) : void
      {
         var _loc5_:XMLList = param2.child("state");
         var _loc6_:uint = _loc5_.length();
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_)
         {
            parseState(param1,_loc5_[_loc7_],param3,param4);
            _loc7_++;
         }
      }
   }
}
