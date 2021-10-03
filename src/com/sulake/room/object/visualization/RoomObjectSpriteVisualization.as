package com.sulake.room.object.visualization
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;
   import com.sulake.room.utils.IRoomGeometry;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class RoomObjectSpriteVisualization implements IRoomObjectSpriteVisualization
   {
      
      private static var var_1150:int = 0;
       
      
      private var var_200:Array;
      
      private var var_366:IRoomObject;
      
      private var var_749:IGraphicAssetCollection;
      
      protected var var_474:int = -1;
      
      protected var var_146:int = -1;
      
      protected var var_88:int = -1;
      
      private var _instanceId:int = 0;
      
      private var _updateID:int = 0;
      
      public function RoomObjectSpriteVisualization()
      {
         super();
         this._instanceId = var_1150++;
         this.var_200 = [];
         this.var_366 = null;
         this.var_749 = null;
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         if(this.var_200 != null)
         {
            while(this.var_200.length > 0)
            {
               _loc1_ = this.var_200[0] as RoomObjectSprite;
               if(_loc1_ != null)
               {
                  _loc1_.dispose();
               }
               this.var_200.pop();
            }
            this.var_200 = null;
         }
         this.var_366 = null;
         this.assetCollection = null;
      }
      
      public function set assetCollection(param1:IGraphicAssetCollection) : void
      {
         if(this.var_749 != null)
         {
            this.var_749.removeReference();
         }
         this.var_749 = param1;
         if(this.var_749 != null)
         {
            this.var_749.addReference();
         }
      }
      
      public function get assetCollection() : IGraphicAssetCollection
      {
         return this.var_749;
      }
      
      public function getUpdateID() : int
      {
         return this._updateID;
      }
      
      public function getInstanceId() : int
      {
         return this._instanceId;
      }
      
      protected function createSprites(param1:int) : void
      {
         var _loc2_:* = null;
         while(this.var_200.length > param1)
         {
            _loc2_ = this.var_200[this.var_200.length - 1] as RoomObjectSprite;
            if(_loc2_ != null)
            {
               _loc2_.dispose();
            }
            this.var_200.pop();
         }
         while(this.var_200.length < param1)
         {
            _loc2_ = new RoomObjectSprite();
            this.var_200.push(_loc2_);
         }
      }
      
      public function get spriteCount() : int
      {
         return this.var_200.length;
      }
      
      public function getSprite(param1:int) : IRoomObjectSprite
      {
         if(param1 >= 0 && param1 < this.var_200.length)
         {
            return this.var_200[param1];
         }
         return null;
      }
      
      public function get object() : IRoomObject
      {
         return this.var_366;
      }
      
      public function set object(param1:IRoomObject) : void
      {
         this.var_366 = param1;
      }
      
      public function update(param1:IRoomGeometry, param2:int, param3:Boolean, param4:Boolean) : void
      {
      }
      
      protected function increaseUpdateId() : void
      {
         ++this._updateID;
      }
      
      protected function reset() : void
      {
         this.var_474 = 4294967295;
         this.var_146 = 4294967295;
         this.var_88 = -1;
      }
      
      public function initialize(param1:IRoomObjectVisualizationData) : Boolean
      {
         return false;
      }
      
      public function get image() : BitmapData
      {
         return this.getImage(0);
      }
      
      public function getImage(param1:int) : BitmapData
      {
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:int = 0;
         var _loc13_:* = 0;
         var _loc14_:* = 0;
         var _loc15_:* = 0;
         var _loc16_:* = null;
         var _loc17_:* = null;
         var _loc2_:Rectangle = this.boundingRectangle;
         if(_loc2_.width * _loc2_.height == 0)
         {
            return null;
         }
         var _loc3_:int = this.spriteCount;
         var _loc4_:* = null;
         var _loc5_:* = [];
         var _loc6_:int = 0;
         var _loc7_:* = null;
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc4_ = this.getSprite(_loc6_);
            if(_loc4_ != null && _loc4_.visible)
            {
               _loc7_ = _loc4_.asset;
               if(_loc7_ != null)
               {
                  _loc5_.push(_loc4_);
               }
            }
            _loc6_++;
         }
         _loc5_.sortOn("relativeDepth",0 | 0);
         var _loc8_:BitmapData = new BitmapData(_loc2_.width,_loc2_.height,true,param1);
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            _loc4_ = _loc5_[_loc6_] as IRoomObjectSprite;
            _loc7_ = _loc4_.asset;
            if(_loc7_ != null)
            {
               _loc12_ = _loc4_.color;
               _loc13_ = _loc12_ >> 16;
               _loc14_ = _loc12_ >> 8 & 255;
               _loc15_ = _loc12_ & 255;
               _loc16_ = null;
               if(_loc13_ < 255 || _loc14_ < 255 || _loc15_ < 255)
               {
                  _loc9_ = _loc13_ / 255;
                  _loc10_ = _loc14_ / 255;
                  _loc11_ = _loc15_ / 255;
                  _loc16_ = new ColorTransform(_loc9_,_loc10_,_loc11_,_loc4_.alpha / 255);
               }
               else if(_loc4_.alpha < 255)
               {
                  _loc16_ = new ColorTransform(1,1,1,_loc4_.alpha / 255);
               }
               if(param1 == 0)
               {
                  if(_loc4_.blendMode == BlendMode.ADD)
                  {
                     if(_loc16_ == null)
                     {
                        _loc16_ = new ColorTransform(1,1,1,0);
                     }
                     else
                     {
                        _loc16_.alphaMultiplier = 0;
                     }
                  }
               }
               _loc17_ = new Matrix();
               if(_loc4_.flipH)
               {
                  _loc17_.scale(-1,1);
                  _loc17_.translate(_loc7_.width,0);
               }
               if(_loc4_.flipV)
               {
                  _loc17_.scale(1,-1);
                  _loc17_.translate(0,_loc7_.height);
               }
               _loc17_.translate(_loc4_.offsetX - _loc2_.left,_loc4_.offsetY - _loc2_.top);
               _loc8_.draw(_loc7_,_loc17_,_loc16_,_loc4_.blendMode,null,false);
            }
            _loc6_++;
         }
         return _loc8_;
      }
      
      public function get boundingRectangle() : Rectangle
      {
         var _loc7_:* = null;
         var _loc1_:int = this.spriteCount;
         var _loc2_:* = null;
         var _loc3_:Rectangle = new Rectangle();
         var _loc4_:int = 0;
         var _loc6_:* = null;
         _loc4_ = 0;
         while(_loc4_ < _loc1_)
         {
            _loc2_ = this.getSprite(_loc4_);
            if(_loc2_ != null && _loc2_.visible)
            {
               _loc6_ = _loc2_.asset;
               if(_loc6_ != null)
               {
                  _loc7_ = new Point(_loc2_.offsetX,_loc2_.offsetY);
                  if(_loc4_ == 0)
                  {
                     _loc3_.left = _loc7_.x;
                     _loc3_.top = _loc7_.y;
                     _loc3_.right = _loc7_.x + _loc2_.width;
                     _loc3_.bottom = _loc7_.y + _loc2_.height;
                  }
                  else
                  {
                     if(_loc7_.x < _loc3_.left)
                     {
                        _loc3_.left = _loc7_.x;
                     }
                     if(_loc7_.y < _loc3_.top)
                     {
                        _loc3_.top = _loc7_.y;
                     }
                     if(_loc7_.x + _loc2_.width > _loc3_.right)
                     {
                        _loc3_.right = _loc7_.x + _loc2_.width;
                     }
                     if(_loc7_.y + _loc2_.height > _loc3_.bottom)
                     {
                        _loc3_.bottom = _loc7_.y + _loc2_.height;
                     }
                  }
               }
            }
            _loc4_++;
         }
         return _loc3_;
      }
   }
}
