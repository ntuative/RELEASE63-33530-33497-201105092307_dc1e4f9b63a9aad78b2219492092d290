package com.sulake.room.object.visualization.utils
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.utils.Map;
   import com.sulake.room.utils.XMLValidator;
   import flash.display.BitmapData;
   import flash.utils.ByteArray;
   
   public class GraphicAssetCollection implements IGraphicAssetCollection
   {
      
      private static const const_1411:int = 10;
       
      
      private var _assets:Map;
      
      private var var_352:IAssetLibrary;
      
      private var var_257:Map;
      
      private var var_616:Array;
      
      private var var_926:int = 0;
      
      public function GraphicAssetCollection()
      {
         super();
         this._assets = new Map();
         this.var_257 = new Map();
         this.var_616 = [];
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(this._assets != null)
         {
            for(_loc1_ in this._assets)
            {
               _loc2_ = this._assets[_loc1_];
               if(_loc2_ != null)
               {
                  _loc2_.dispose();
               }
            }
            this._assets.dispose();
            this._assets = null;
         }
         if(this.var_257 != null)
         {
            for(_loc1_ in this.var_257)
            {
               _loc3_ = this.var_257[_loc1_];
               if(_loc3_ != null)
               {
                  _loc3_.dispose();
               }
            }
            this.var_257.dispose();
            this.var_257 = null;
         }
         if(this.var_616 != null)
         {
            this.disposePaletteAssets();
            this.var_616 = null;
         }
         this.var_352 = null;
      }
      
      public function set assetLibrary(param1:IAssetLibrary) : void
      {
         this.var_352 = param1;
      }
      
      public function addReference() : void
      {
         ++this.var_926;
      }
      
      public function removeReference() : void
      {
         --this.var_926;
         if(this.var_926 <= 0)
         {
            this.var_926 = 0;
            this.disposePaletteAssets(false);
         }
      }
      
      public function define(param1:XML) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var _loc2_:XMLList = param1.asset;
         if(_loc2_ == null)
         {
            return false;
         }
         var _loc3_:XMLList = param1.palette;
         if(_loc3_ != null)
         {
            this.definePalettes(_loc3_);
         }
         this.defineAssets(_loc2_);
         return true;
      }
      
      private function defineAssets(param1:XMLList) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:Boolean = false;
         var _loc8_:Boolean = false;
         var _loc9_:* = false;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:* = null;
         var _loc13_:Boolean = false;
         var _loc14_:* = null;
         var _loc2_:int = param1.length();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1[_loc3_];
            _loc5_ = _loc4_.@name;
            if(_loc5_.length > 0)
            {
               _loc6_ = null;
               _loc7_ = false;
               _loc8_ = false;
               _loc9_ = false;
               _loc10_ = 0;
               _loc11_ = 0;
               _loc10_ = -int(_loc4_.@x);
               _loc11_ = -int(_loc4_.@y);
               _loc6_ = _loc4_.@source;
               if(int(_loc4_.@flipH) > 0)
               {
                  if(_loc6_.length > 0)
                  {
                     _loc7_ = true;
                  }
               }
               if(int(_loc4_.@flipV) > 0)
               {
                  if(_loc6_.length > 0)
                  {
                     _loc8_ = true;
                  }
               }
               _loc9_ = int(_loc4_.@usesPalette) != 0;
               if(_loc6_.length == 0)
               {
                  _loc6_ = _loc5_;
               }
               _loc12_ = this.var_352.getAssetByName(_loc6_);
               if(_loc12_ != null)
               {
                  _loc13_ = this.createAsset(_loc5_,_loc6_,_loc12_,_loc7_,_loc8_,_loc10_,_loc11_,_loc9_);
                  if(!_loc13_)
                  {
                     _loc14_ = this.getAsset(_loc5_);
                     if(_loc14_ != null && _loc14_.assetName != _loc14_.libraryAssetName)
                     {
                        _loc13_ = this.replaceAsset(_loc5_,_loc6_,_loc12_,_loc7_,_loc8_,_loc10_,_loc11_,_loc9_);
                     }
                  }
               }
            }
            _loc3_++;
         }
      }
      
      private function definePalettes(param1:XMLList) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc2_:* = ["id","source"];
         for each(_loc3_ in param1)
         {
            if(XMLValidator.checkRequiredAttributes(_loc3_,_loc2_))
            {
               _loc4_ = _loc3_.@id;
               _loc5_ = _loc3_.@source;
               if(this.var_257[_loc4_] == null)
               {
                  _loc6_ = this.var_352.getAssetByName(_loc5_);
                  if(_loc6_.content is Class)
                  {
                     _loc7_ = new _loc6_.content() as ByteArray;
                  }
                  else
                  {
                     _loc7_ = _loc6_.content as ByteArray;
                  }
                  _loc8_ = 16777215;
                  _loc9_ = 16777215;
                  _loc10_ = _loc3_.@color1;
                  if(_loc10_.length > 0)
                  {
                     _loc8_ = parseInt(_loc10_,16);
                     _loc9_ = _loc8_;
                  }
                  _loc10_ = _loc3_.@color2;
                  if(_loc10_.length > 0)
                  {
                     _loc9_ = parseInt(_loc10_,16);
                  }
                  _loc11_ = new GraphicAssetPalette(_loc7_,_loc8_,_loc9_);
                  this.var_257[_loc4_] = _loc11_;
               }
            }
         }
      }
      
      protected function createAsset(param1:String, param2:String, param3:IAsset, param4:Boolean, param5:Boolean, param6:Number, param7:Number, param8:Boolean) : Boolean
      {
         if(this._assets[param1] != null)
         {
            return false;
         }
         var _loc9_:GraphicAsset = new GraphicAsset(param1,param2,param3,param4,param5,param6,param7,param8);
         this._assets[param1] = _loc9_;
         return true;
      }
      
      protected function replaceAsset(param1:String, param2:String, param3:IAsset, param4:Boolean, param5:Boolean, param6:Number, param7:Number, param8:Boolean) : Boolean
      {
         var _loc9_:GraphicAsset = this._assets.remove(param1);
         if(_loc9_ != null)
         {
            _loc9_.dispose();
         }
         return this.createAsset(param1,param2,param3,param4,param5,param6,param7,param8);
      }
      
      public function getAsset(param1:String) : IGraphicAsset
      {
         return this._assets[param1];
      }
      
      public function getAssetWithPalette(param1:String, param2:String) : IGraphicAsset
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc3_:String = param1 + "@" + param2;
         var _loc4_:IGraphicAsset = this.getAsset(_loc3_);
         if(_loc4_ == null)
         {
            _loc5_ = this.getAsset(param1);
            if(_loc5_ == null || !_loc5_.usesPalette)
            {
               return _loc5_;
            }
            _loc6_ = _loc5_.libraryAssetName + "@" + param2;
            _loc7_ = this.getLibraryAsset(_loc6_);
            if(_loc7_ == null)
            {
               _loc8_ = _loc5_.asset.content as BitmapData;
               if(_loc8_ != null)
               {
                  _loc9_ = this.getPalette(param2);
                  if(_loc9_ == null)
                  {
                     return _loc5_;
                  }
                  _loc10_ = _loc8_.clone();
                  _loc9_.colorizeBitmap(_loc10_);
                  _loc7_ = this.addLibraryAsset(_loc6_,_loc10_);
                  if(_loc7_ == null)
                  {
                     _loc10_.dispose();
                     return null;
                  }
               }
            }
            this.var_616.push(_loc3_);
            this.createAsset(_loc3_,_loc6_,_loc7_,_loc5_.flipH,_loc5_.flipV,_loc5_.originalOffsetX,_loc5_.originalOffsetY,false);
            _loc4_ = this.getAsset(_loc3_);
         }
         return _loc4_;
      }
      
      public function getPaletteNames() : Array
      {
         return this.var_257.getKeys();
      }
      
      public function getPaletteColors(param1:String) : Array
      {
         var _loc2_:GraphicAssetPalette = this.getPalette(param1);
         if(_loc2_ != null)
         {
            return [_loc2_.primaryColor,_loc2_.secondaryColor];
         }
         return null;
      }
      
      private function getPalette(param1:String) : GraphicAssetPalette
      {
         return this.var_257[param1];
      }
      
      public function addAsset(param1:String, param2:BitmapData, param3:Boolean, param4:int = 0, param5:int = 0, param6:Boolean = false, param7:Boolean = false) : Boolean
      {
         var _loc9_:* = null;
         if(param1 == null || param2 == null)
         {
            return false;
         }
         if(this.var_352 == null)
         {
            return false;
         }
         var _loc8_:BitmapDataAsset = this.getLibraryAsset(param1);
         if(_loc8_ == null)
         {
            _loc8_ = new BitmapDataAsset(this.var_352.getAssetTypeDeclarationByClass(BitmapDataAsset));
            this.var_352.setAsset(param1,_loc8_);
            _loc8_.setUnknownContent(param2);
            return this.createAsset(param1,param1,_loc8_,param6,param7,param4,param5,false);
         }
         if(param3)
         {
            _loc9_ = _loc8_.content as BitmapData;
            if(_loc9_ != null && _loc9_ != param2)
            {
               _loc9_.dispose();
            }
            _loc8_.setUnknownContent(param2);
         }
         return false;
      }
      
      public function disposeAsset(param1:String) : void
      {
         var _loc3_:* = null;
         var _loc2_:GraphicAsset = this._assets.remove(param1);
         if(_loc2_ != null)
         {
            _loc3_ = this.getLibraryAsset(_loc2_.libraryAssetName);
            if(_loc3_ != null)
            {
               this.var_352.removeAsset(_loc3_);
               _loc3_.dispose();
            }
            _loc2_.dispose();
         }
      }
      
      private function getLibraryAsset(param1:String) : BitmapDataAsset
      {
         return this.var_352.getAssetByName(param1) as BitmapDataAsset;
      }
      
      private function addLibraryAsset(param1:String, param2:BitmapData) : BitmapDataAsset
      {
         var _loc3_:BitmapDataAsset = this.getLibraryAsset(param1);
         if(_loc3_ == null)
         {
            _loc3_ = new BitmapDataAsset(this.var_352.getAssetTypeDeclarationByClass(BitmapDataAsset));
            this.var_352.setAsset(param1,_loc3_);
            _loc3_.setUnknownContent(param2);
            return _loc3_;
         }
         return null;
      }
      
      private function disposePaletteAssets(param1:Boolean = true) : void
      {
         var _loc2_:* = null;
         if(this.var_616 != null)
         {
            if(param1 || this.var_616.length > const_1411)
            {
               for each(_loc2_ in this.var_616)
               {
                  this.disposeAsset(_loc2_);
               }
               this.var_616 = [];
            }
         }
      }
   }
}
