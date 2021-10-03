package com.sulake.habbo.room.object.visualization.avatar
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.avatar.IAvatarImage;
   import com.sulake.habbo.avatar.IAvatarImageListener;
   import com.sulake.habbo.avatar.animation.IAnimationLayerData;
   import com.sulake.habbo.avatar.animation.ISpriteDataContainer;
   import com.sulake.habbo.avatar.enum.AvatarAction;
   import com.sulake.habbo.avatar.enum.AvatarSetType;
   import com.sulake.habbo.room.object.RoomObjectVariableEnum;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
   import com.sulake.room.object.visualization.RoomObjectSpriteVisualization;
   import com.sulake.room.utils.IRoomGeometry;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   
   public class AvatarVisualization extends RoomObjectSpriteVisualization implements IAvatarImageListener
   {
      
      private static const const_994:String = "avatar";
      
      private static const const_650:Number = -0.01;
      
      private static const const_649:Number = -0.409;
      
      private static const const_995:int = 2;
      
      private static const const_1351:Array = [0,0,0];
      
      private static const const_1350:int = 3;
       
      
      private var var_579:AvatarVisualizationData = null;
      
      private var var_491:Map;
      
      private var var_484:Map;
      
      private var var_1107:int = 0;
      
      private var var_910:Boolean;
      
      private var var_692:String;
      
      private var var_1060:String;
      
      private var var_1108:int = 0;
      
      private var var_577:BitmapDataAsset;
      
      private var var_875:BitmapDataAsset;
      
      private var var_1628:int = -1;
      
      private var var_1633:int = -1;
      
      private var var_1631:int = -1;
      
      private const const_996:int = 0;
      
      private const const_1902:int = 1;
      
      private const const_1898:int = 2;
      
      private const const_1899:int = 3;
      
      private const const_1352:int = 4;
      
      private var var_1724:int = -1;
      
      private var var_241:String = "";
      
      private var _postureParameter:String = "";
      
      private var var_1635:Boolean = false;
      
      private var var_1630:Boolean = false;
      
      private var var_1629:Boolean = false;
      
      private var var_1344:Boolean = false;
      
      private var var_580:Boolean = false;
      
      private var var_1345:int = 0;
      
      private var var_1347:int = 0;
      
      private var var_2158:int = 0;
      
      private var var_710:int = 0;
      
      private var var_712:int = 0;
      
      private var var_578:int = 0;
      
      private var var_1346:int = 0;
      
      private var var_1085:Boolean = false;
      
      private var var_1634:Boolean = false;
      
      private var var_1086:int = 0;
      
      private var var_711:int = 0;
      
      private var var_1632:Boolean = false;
      
      private var var_1087:int = 0;
      
      private var var_56:IAvatarImage = null;
      
      private var var_1076:Boolean;
      
      public function AvatarVisualization()
      {
         super();
         this.var_491 = new Map();
         this.var_484 = new Map();
         this.var_910 = false;
      }
      
      override public function dispose() : void
      {
         if(this.var_491 != null)
         {
            this.resetImages();
            this.var_491.dispose();
            this.var_484.dispose();
            this.var_491 = null;
         }
         this.var_579 = null;
         this.var_577 = null;
         this.var_875 = null;
         super.dispose();
         this.var_1076 = true;
      }
      
      public function get disposed() : Boolean
      {
         return this.var_1076;
      }
      
      override public function initialize(param1:IRoomObjectVisualizationData) : Boolean
      {
         this.var_579 = param1 as AvatarVisualizationData;
         createSprites(this.const_1352);
         return true;
      }
      
      private function updateModel(param1:IRoomObjectModel, param2:Number, param3:Boolean) : Boolean
      {
         var _loc4_:Boolean = false;
         var _loc5_:* = false;
         var _loc6_:int = 0;
         var _loc7_:* = null;
         var _loc8_:* = null;
         if(param1.getUpdateID() != var_146)
         {
            _loc4_ = false;
            _loc5_ = false;
            _loc6_ = 0;
            _loc7_ = "";
            _loc5_ = Boolean(param1.getNumber(RoomObjectVariableEnum.const_243) > 0 && param3);
            if(_loc5_ != this.var_1635)
            {
               this.var_1635 = _loc5_;
               _loc4_ = true;
            }
            _loc5_ = param1.getNumber(RoomObjectVariableEnum.const_403) > 0;
            if(_loc5_ != this.var_1630)
            {
               this.var_1630 = _loc5_;
               _loc4_ = true;
            }
            _loc5_ = param1.getNumber(RoomObjectVariableEnum.const_377) > 0;
            if(_loc5_ != this.var_1629)
            {
               this.var_1629 = _loc5_;
               _loc4_ = true;
            }
            _loc5_ = Boolean(param1.getNumber(RoomObjectVariableEnum.const_947) > 0 && param3);
            if(_loc5_ != this.var_1344)
            {
               this.var_1344 = _loc5_;
               _loc4_ = true;
            }
            _loc5_ = param1.getNumber(RoomObjectVariableEnum.const_1181) > 0;
            if(_loc5_ != this.var_580)
            {
               this.var_580 = _loc5_;
               _loc4_ = true;
               this.updateTypingBubble(param2);
            }
            _loc6_ = param1.getNumber(RoomObjectVariableEnum.const_153);
            if(_loc6_ != this.var_1345)
            {
               this.var_1345 = _loc6_;
               _loc4_ = true;
            }
            _loc7_ = param1.getString(RoomObjectVariableEnum.const_240);
            if(_loc7_ != this.var_241)
            {
               this.var_241 = _loc7_;
               _loc4_ = true;
            }
            _loc7_ = param1.getString(RoomObjectVariableEnum.const_937);
            if(_loc7_ != this._postureParameter)
            {
               this._postureParameter = _loc7_;
               _loc4_ = true;
            }
            _loc6_ = param1.getNumber(RoomObjectVariableEnum.const_1297);
            if(_loc6_ != this.var_1347)
            {
               this.var_1347 = _loc6_;
               _loc4_ = true;
            }
            _loc6_ = param1.getNumber(RoomObjectVariableEnum.const_533);
            if(_loc6_ != this.var_710)
            {
               this.var_710 = _loc6_;
               _loc4_ = true;
            }
            _loc6_ = param1.getNumber(RoomObjectVariableEnum.const_509);
            if(_loc6_ != this.var_712)
            {
               this.var_712 = _loc6_;
               _loc4_ = true;
            }
            _loc6_ = param1.getNumber(RoomObjectVariableEnum.const_376);
            if(_loc6_ != this.var_578)
            {
               this.var_578 = _loc6_;
               _loc4_ = true;
            }
            _loc6_ = param1.getNumber(RoomObjectVariableEnum.const_192);
            if(_loc6_ != this.var_1628)
            {
               this.var_1628 = _loc6_;
               _loc4_ = true;
            }
            if(this.var_712 > 0 && param1.getNumber(RoomObjectVariableEnum.const_376) > 0)
            {
               if(this.var_578 != this.var_712)
               {
                  this.var_578 = this.var_712;
                  _loc4_ = true;
               }
            }
            else if(this.var_578 != 0)
            {
               this.var_578 = 0;
               _loc4_ = true;
            }
            _loc6_ = param1.getNumber(RoomObjectVariableEnum.const_933);
            if(_loc6_ != this.var_1086)
            {
               this.var_1086 = _loc6_;
               _loc4_ = true;
               this.updateNumberBubble(param2);
            }
            this.validateActions(param2);
            _loc7_ = param1.getString(RoomObjectVariableEnum.AVATAR_GENDER);
            if(_loc7_ != this.var_1060)
            {
               this.var_1060 = _loc7_;
               _loc4_ = true;
            }
            _loc8_ = param1.getString(RoomObjectVariableEnum.const_221);
            if(this.updateFigure(_loc8_))
            {
               _loc4_ = true;
            }
            var_146 = param1.getUpdateID();
            return _loc4_;
         }
         return false;
      }
      
      private function updateFigure(param1:String) : Boolean
      {
         if(this.var_692 != param1)
         {
            this.var_692 = param1;
            this.resetImages();
            return true;
         }
         return false;
      }
      
      private function resetImages() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         for each(_loc1_ in this.var_491)
         {
            if(_loc1_)
            {
               _loc1_.dispose();
            }
         }
         for each(_loc1_ in this.var_484)
         {
            if(_loc1_)
            {
               _loc1_.dispose();
            }
         }
         this.var_491.reset();
         this.var_484.reset();
         this.var_56 = null;
         _loc2_ = getSprite(this.const_996);
         if(_loc2_ != null)
         {
            _loc2_.asset = null;
            _loc2_.alpha = 255;
         }
      }
      
      private function validateActions(param1:Number) : void
      {
         var _loc2_:int = 0;
         if(param1 < 48)
         {
            this.var_1344 = false;
         }
         if(this.var_241 == "sit" || this.var_241 == "lay")
         {
            this.var_1346 = param1 / 2;
         }
         else
         {
            this.var_1346 = 0;
         }
         this.var_1634 = false;
         this.var_1085 = false;
         if(this.var_241 == "lay")
         {
            this.var_1085 = true;
            _loc2_ = int(this._postureParameter);
            if(_loc2_ < 0)
            {
               this.var_1634 = true;
            }
         }
      }
      
      private function getAvatarImage(param1:Number, param2:int) : IAvatarImage
      {
         var _loc3_:* = null;
         var _loc4_:String = "avatarImage" + param1.toString();
         if(param2 == 0)
         {
            _loc3_ = this.var_491.getValue(_loc4_) as IAvatarImage;
         }
         else
         {
            _loc4_ += "-" + param2;
            _loc3_ = this.var_484.getValue(_loc4_) as IAvatarImage;
         }
         if(_loc3_ == null)
         {
            _loc3_ = this.var_579.getAvatar(this.var_692,param1,this.var_1060,this);
            if(_loc3_ != null)
            {
               if(param2 == 0)
               {
                  this.var_491.add(_loc4_,_loc3_);
               }
               else
               {
                  if(this.var_484.length >= const_1350)
                  {
                     this.var_484.remove(this.var_484.getKeys().shift());
                  }
                  this.var_484.add(_loc4_,_loc3_);
               }
            }
         }
         return _loc3_;
      }
      
      private function updateObject(param1:IRoomObject, param2:IRoomGeometry, param3:Boolean, param4:Boolean = false) : Boolean
      {
         var _loc5_:Boolean = false;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         if(param4 || var_474 != param1.getUpdateID() || this.var_1724 != param2.updateId)
         {
            _loc5_ = param3;
            _loc6_ = param1.getDirection().x - param2.direction.x;
            _loc6_ = (_loc6_ % 360 + 360) % 360;
            _loc7_ = this.var_1628;
            if(this.var_241 == "float")
            {
               _loc7_ = _loc6_;
            }
            else
            {
               _loc7_ -= param2.direction.x;
            }
            _loc7_ = (_loc7_ % 360 + 360) % 360;
            if(_loc6_ != this.var_1633 || param4)
            {
               _loc5_ = true;
               this.var_1633 = _loc6_;
               _loc6_ -= 112.5;
               _loc6_ = (_loc6_ + 360) % 360;
               this.var_56.setDirectionAngle(AvatarSetType.const_35,_loc6_);
            }
            if(_loc7_ != this.var_1631 || param4)
            {
               _loc5_ = true;
               this.var_1631 = _loc7_;
               if(this.var_1631 != this.var_1633)
               {
                  _loc7_ -= 112.5;
                  _loc7_ = (_loc7_ + 360) % 360;
                  this.var_56.setDirectionAngle(AvatarSetType.const_51,_loc7_);
               }
            }
            var_474 = param1.getUpdateID();
            this.var_1724 = param2.updateId;
            return _loc5_;
         }
         return false;
      }
      
      private function updateShadow(param1:Number) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:IRoomObjectSprite = getSprite(this.const_1902);
         this.var_577 = null;
         if(this.var_241 == "mv" || this.var_241 == "std")
         {
            _loc2_.visible = true;
            if(this.var_577 == null || param1 != var_88)
            {
               _loc3_ = 0;
               _loc4_ = 0;
               if(param1 < 48)
               {
                  this.var_577 = this.var_56.getAsset("sh_std_sd_1_0_0");
                  _loc3_ = -8;
                  _loc4_ = -3;
               }
               else
               {
                  this.var_577 = this.var_56.getAsset("h_std_sd_1_0_0");
                  _loc3_ = -17;
                  _loc4_ = -7;
               }
               if(this.var_577 != null)
               {
                  _loc2_.asset = this.var_577.content as BitmapData;
                  _loc2_.offsetX = _loc3_;
                  _loc2_.offsetY = _loc4_;
                  _loc2_.alpha = 50;
                  _loc2_.relativeDepth = 1;
               }
               else
               {
                  _loc2_.visible = false;
               }
            }
         }
         else
         {
            this.var_577 = null;
            _loc2_.visible = false;
         }
      }
      
      private function updateTypingBubble(param1:Number) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         this.var_875 = null;
         var _loc2_:IRoomObjectSprite = getSprite(this.const_1898);
         if(this.var_580)
         {
            _loc2_.visible = true;
            _loc5_ = 64;
            if(param1 < 48)
            {
               this.var_875 = this.var_579.getAvatarRendererAsset("user_typing_small_png") as BitmapDataAsset;
               _loc3_ = 3;
               _loc4_ = -42;
               _loc5_ = 32;
            }
            else
            {
               this.var_875 = this.var_579.getAvatarRendererAsset("user_typing_png") as BitmapDataAsset;
               _loc3_ = 14;
               _loc4_ = -83;
            }
            if(this.var_241 == "sit")
            {
               _loc4_ += _loc5_ / 2;
            }
            else if(this.var_241 == "lay")
            {
               _loc4_ += _loc5_;
            }
            if(this.var_875 != null)
            {
               _loc2_.asset = this.var_875.content as BitmapData;
               _loc2_.offsetX = _loc3_;
               _loc2_.offsetY = _loc4_;
               _loc2_.relativeDepth = -0.02;
            }
         }
         else
         {
            _loc2_.visible = false;
         }
      }
      
      private function updateNumberBubble(param1:Number) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:* = null;
         var _loc3_:IRoomObjectSprite = getSprite(this.const_1899);
         if(this.var_1086 > 0)
         {
            _loc6_ = 64;
            if(param1 < 48)
            {
               _loc2_ = this.var_579.getAvatarRendererAsset("number_" + this.var_1086 + "_small_png") as BitmapDataAsset;
               _loc4_ = -6;
               _loc5_ = -52;
               _loc6_ = 32;
            }
            else
            {
               _loc2_ = this.var_579.getAvatarRendererAsset("number_" + this.var_1086 + "_png") as BitmapDataAsset;
               _loc4_ = -8;
               _loc5_ = -105;
            }
            if(this.var_241 == "sit")
            {
               _loc5_ += _loc6_ / 2;
            }
            else if(this.var_241 == "lay")
            {
               _loc5_ += _loc6_;
            }
            if(_loc2_ != null)
            {
               _loc3_.visible = true;
               _loc3_.asset = _loc2_.content as BitmapData;
               _loc3_.offsetX = _loc4_;
               _loc3_.offsetY = _loc5_;
               _loc3_.relativeDepth = -0.01;
               this.var_711 = 1;
               this.var_1632 = true;
               this.var_1087 = 0;
               _loc3_.alpha = 0;
            }
            else
            {
               _loc3_.visible = false;
            }
         }
         else if(_loc3_.visible)
         {
            this.var_711 = -1;
         }
      }
      
      private function animateNumberBubble(param1:int) : Boolean
      {
         var _loc5_:int = 0;
         var _loc2_:IRoomObjectSprite = getSprite(this.const_1899);
         var _loc3_:int = _loc2_.alpha;
         var _loc4_:Boolean = false;
         if(this.var_1632)
         {
            ++this.var_1087;
            if(this.var_1087 < 10)
            {
               return false;
            }
            if(this.var_711 < 0)
            {
               if(param1 < 48)
               {
                  _loc2_.offsetY -= 2;
               }
               else
               {
                  _loc2_.offsetY -= 4;
               }
            }
            else
            {
               _loc5_ = 4;
               if(param1 < 48)
               {
                  _loc5_ = 8;
               }
               if(this.var_1087 % _loc5_ == 0)
               {
                  --_loc2_.offsetY;
                  _loc4_ = true;
               }
            }
         }
         if(this.var_711 > 0)
         {
            if(_loc3_ < 255)
            {
               _loc3_ += 32;
            }
            if(_loc3_ >= 255)
            {
               _loc3_ = 255;
               this.var_711 = 0;
            }
            _loc2_.alpha = _loc3_;
            return true;
         }
         if(this.var_711 < 0)
         {
            if(_loc3_ >= 0)
            {
               _loc3_ -= 32;
            }
            if(_loc3_ <= 0)
            {
               this.var_711 = 0;
               this.var_1632 = false;
               _loc3_ = 0;
               _loc2_.visible = false;
            }
            _loc2_.alpha = _loc3_;
            return true;
         }
         return _loc4_;
      }
      
      override public function update(param1:IRoomGeometry, param2:int, param3:Boolean, param4:Boolean) : void
      {
         var _loc16_:* = null;
         var _loc17_:* = null;
         var _loc18_:* = null;
         var _loc19_:int = 0;
         var _loc20_:* = null;
         var _loc21_:* = null;
         var _loc22_:* = null;
         var _loc23_:int = 0;
         var _loc24_:int = 0;
         var _loc25_:* = null;
         var _loc26_:int = 0;
         var _loc27_:int = 0;
         var _loc28_:int = 0;
         var _loc29_:int = 0;
         var _loc30_:int = 0;
         var _loc31_:* = null;
         var _loc32_:* = null;
         var _loc5_:IRoomObject = object;
         if(_loc5_ == null)
         {
            return;
         }
         if(param1 == null)
         {
            return;
         }
         if(this.var_579 == null)
         {
            return;
         }
         var _loc6_:IRoomObjectModel = _loc5_.getModel();
         var _loc7_:Number = param1.scale;
         var _loc8_:Boolean = false;
         var _loc9_:Boolean = false;
         var _loc10_:Boolean = false;
         var _loc11_:int = this.var_710;
         var _loc12_:Boolean = false;
         var _loc13_:Boolean = this.updateModel(_loc6_,_loc7_,param3);
         if(this.animateNumberBubble(_loc7_))
         {
            increaseUpdateId();
         }
         if(_loc13_ || _loc7_ != var_88 || this.var_56 == null)
         {
            if(_loc7_ != var_88)
            {
               _loc9_ = true;
               this.validateActions(_loc7_);
            }
            if(_loc11_ != this.var_710)
            {
               _loc12_ = true;
            }
            if(_loc9_ || this.var_56 == null || _loc12_)
            {
               this.var_56 = this.getAvatarImage(_loc7_,this.var_710);
               if(this.var_56 == null)
               {
                  return;
               }
               _loc8_ = true;
               _loc16_ = getSprite(this.const_996);
               if(_loc16_ && this.var_56 && this.var_56.isPlaceholder())
               {
                  _loc16_.alpha = 150;
               }
               else if(_loc16_)
               {
                  _loc16_.alpha = 255;
               }
            }
            if(this.var_56 == null)
            {
               return;
            }
            this.updateShadow(_loc7_);
            if(_loc9_)
            {
               this.updateTypingBubble(_loc7_);
               this.updateNumberBubble(_loc7_);
            }
            _loc10_ = this.updateObject(_loc5_,param1,param3,true);
            this.updateActions(this.var_56);
            var_88 = _loc7_;
         }
         else
         {
            _loc10_ = this.updateObject(_loc5_,param1,param3);
         }
         var _loc14_:Boolean = _loc10_ || _loc13_ || _loc9_;
         var _loc15_:Boolean = (this.var_910 || this.var_1108 > 0) && param3;
         if(_loc14_)
         {
            this.var_1108 = const_995;
         }
         if(_loc14_ || _loc15_)
         {
            increaseUpdateId();
            --this.var_1108;
            --this.var_1107;
            if(!(this.var_1107 <= 0 || _loc9_ || _loc13_ || _loc8_))
            {
               return;
            }
            this.var_56.updateAnimationByFrames(1);
            this.var_1107 = const_995;
            _loc18_ = this.var_56.getCanvasOffsets();
            if(_loc18_ == null || _loc18_.length < 3)
            {
               _loc18_ = const_1351;
            }
            _loc17_ = getSprite(this.const_996);
            if(_loc17_ != null)
            {
               _loc21_ = this.var_56.getImage(AvatarSetType.const_35,false);
               if(_loc21_ != null)
               {
                  _loc17_.asset = _loc21_;
               }
               if(_loc17_.asset)
               {
                  _loc17_.offsetX = -1 * _loc7_ / 2 + _loc18_[0];
                  _loc17_.offsetY = -_loc17_.asset.height + _loc7_ / 4 + _loc18_[1] + this.var_1346;
               }
               if(this.var_1085)
               {
                  if(this.var_1634)
                  {
                     _loc17_.relativeDepth = -0.5;
                  }
                  else
                  {
                     _loc17_.relativeDepth = const_649 + _loc18_[2];
                  }
               }
               else
               {
                  _loc17_.relativeDepth = const_650 + _loc18_[2];
               }
            }
            _loc17_ = getSprite(this.const_1898);
            if(_loc17_ != null && _loc17_.visible)
            {
               if(!this.var_1085)
               {
                  _loc17_.relativeDepth = const_650 - 0.01 + _loc18_[2];
               }
               else
               {
                  _loc17_.relativeDepth = const_649 - 0.01 + _loc18_[2];
               }
            }
            this.var_910 = this.var_56.isAnimating();
            _loc19_ = this.const_1352;
            for each(_loc20_ in this.var_56.getSprites())
            {
               if(_loc20_.id == const_994)
               {
                  _loc17_ = getSprite(this.const_996);
                  _loc22_ = this.var_56.getLayerData(_loc20_);
                  _loc23_ = _loc20_.getDirectionOffsetX(this.var_56.getDirection());
                  _loc24_ = _loc20_.getDirectionOffsetY(this.var_56.getDirection());
                  if(_loc22_ != null)
                  {
                     _loc23_ += _loc22_.dx;
                     _loc24_ += _loc22_.dy;
                  }
                  if(_loc7_ < 48)
                  {
                     _loc23_ /= 2;
                     _loc24_ /= 2;
                  }
                  _loc17_.offsetX += _loc23_;
                  _loc17_.offsetY += _loc24_;
               }
               else
               {
                  _loc17_ = getSprite(_loc19_);
                  if(_loc17_ != null)
                  {
                     _loc17_.capturesMouse = false;
                     _loc17_.visible = true;
                     _loc25_ = this.var_56.getLayerData(_loc20_);
                     _loc26_ = 0;
                     _loc27_ = _loc20_.getDirectionOffsetX(this.var_56.getDirection());
                     _loc28_ = _loc20_.getDirectionOffsetY(this.var_56.getDirection());
                     _loc29_ = _loc20_.getDirectionOffsetZ(this.var_56.getDirection());
                     _loc30_ = 0;
                     if(_loc20_.hasDirections)
                     {
                        _loc30_ = this.var_56.getDirection();
                     }
                     if(_loc25_ != null)
                     {
                        _loc26_ = _loc25_.animationFrame;
                        _loc27_ += _loc25_.dx;
                        _loc28_ += _loc25_.dy;
                        _loc30_ += _loc25_.directionOffset;
                     }
                     if(_loc7_ < 48)
                     {
                        _loc27_ /= 2;
                        _loc28_ /= 2;
                     }
                     if(_loc30_ < 0)
                     {
                        _loc30_ += 8;
                     }
                     else if(_loc30_ > 7)
                     {
                        _loc30_ -= 8;
                     }
                     _loc31_ = this.var_56.getScale() + "_" + _loc20_.member + "_" + _loc30_ + "_" + _loc26_;
                     _loc32_ = this.var_56.getAsset(_loc31_);
                     if(_loc32_ == null)
                     {
                        continue;
                     }
                     _loc17_.asset = _loc32_.content as BitmapData;
                     _loc17_.offsetX = -_loc32_.offset.x - _loc7_ / 2 + _loc27_;
                     _loc17_.offsetY = -_loc32_.offset.y + _loc28_ + this.var_1346;
                     if(this.var_1085)
                     {
                        _loc17_.relativeDepth = const_649 - 0.001 * spriteCount * _loc29_;
                     }
                     else
                     {
                        _loc17_.relativeDepth = const_650 - 0.001 * spriteCount * _loc29_;
                     }
                     if(_loc20_.ink == 33)
                     {
                        _loc17_.blendMode = BlendMode.ADD;
                     }
                     else
                     {
                        _loc17_.blendMode = BlendMode.NORMAL;
                     }
                  }
                  _loc19_++;
               }
            }
         }
      }
      
      private function updateActions(param1:IAvatarImage) : void
      {
         var _loc3_:* = null;
         if(param1 == null)
         {
            return;
         }
         param1.initActionAppends();
         param1.appendAction(AvatarAction.const_446,this.var_241,this._postureParameter);
         if(this.var_1345 > 0)
         {
            param1.appendAction(AvatarAction.const_301,AvatarAction.const_1719[this.var_1345]);
         }
         if(this.var_1347 > 0)
         {
            param1.appendAction(AvatarAction.const_785,this.var_1347);
         }
         if(this.var_2158 > 0)
         {
            param1.appendAction(AvatarAction.const_930,this.var_2158);
         }
         if(this.var_712 > 0)
         {
            param1.appendAction(AvatarAction.const_780,this.var_712);
         }
         if(this.var_578 > 0)
         {
            param1.appendAction(AvatarAction.const_838,this.var_578);
         }
         if(this.var_1635)
         {
            param1.appendAction(AvatarAction.const_332);
         }
         if(this.var_1629 || this.var_1344)
         {
            param1.appendAction(AvatarAction.const_525);
         }
         if(this.var_1630)
         {
            param1.appendAction(AvatarAction.const_257);
         }
         if(this.var_710 > 0)
         {
            param1.appendAction(AvatarAction.const_365,this.var_710);
         }
         param1.endActionAppends();
         this.var_910 = param1.isAnimating();
         var _loc2_:int = this.const_1352;
         for each(_loc3_ in this.var_56.getSprites())
         {
            if(_loc3_.id != const_994)
            {
               _loc2_++;
            }
         }
         if(_loc2_ != spriteCount)
         {
            createSprites(_loc2_);
         }
      }
      
      public function avatarImageReady(param1:String) : void
      {
         this.resetImages();
      }
   }
}
