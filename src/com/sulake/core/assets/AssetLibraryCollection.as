package com.sulake.core.assets
{
   import com.sulake.core.runtime.events.EventDispatcher;
   import com.sulake.core.utils.LibraryLoader;
   import com.sulake.core.utils.LibraryLoaderEvent;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   
   public class AssetLibraryCollection extends EventDispatcher implements IAssetLibrary
   {
       
      
      protected var var_28:Array;
      
      protected var var_572:Array;
      
      protected var var_1067:LoaderContext;
      
      protected var var_481:AssetLibrary;
      
      protected var _manifest:XML;
      
      protected var _name:String;
      
      private var var_573:uint = 0;
      
      public function AssetLibraryCollection(param1:String)
      {
         super();
         this._name = param1;
         this._manifest = new XML();
         this.var_28 = new Array();
         this.var_572 = new Array();
         this.var_1067 = new LoaderContext(false,ApplicationDomain.currentDomain,null);
         this.var_481 = new AssetLibrary("lib-" + this.var_573++);
         this.var_28.push(this.var_481);
      }
      
      public function get url() : String
      {
         return "";
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get isReady() : Boolean
      {
         return this.var_572.length == 0;
      }
      
      public function get numAssets() : uint
      {
         return this.getNumAssets();
      }
      
      public function get nameArray() : Array
      {
         return this.getAssetNameArray();
      }
      
      public function get manifest() : XML
      {
         return this._manifest;
      }
      
      public function get loaderContext() : LoaderContext
      {
         return this.var_1067;
      }
      
      public function set loaderContext(param1:LoaderContext) : void
      {
         this.var_1067 = param1;
      }
      
      public function loadFromFile(param1:LibraryLoader, param2:Boolean = false) : void
      {
         if(this.loaderContext == null)
         {
            this.loaderContext = this.var_1067;
         }
         var _loc3_:IAssetLibrary = new AssetLibrary("lib-" + this.var_573++);
         this.var_572.push(_loc3_);
         _loc3_.loadFromFile(param1,param2);
         param1.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE,this.loadEventHandler);
         param1.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR,this.loadEventHandler);
         param1.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_PROGRESS,this.loadEventHandler);
      }
      
      public function loadFromResource(param1:XML, param2:Class) : Boolean
      {
         return this.var_481.loadFromResource(param1,param2);
      }
      
      public function unload() : void
      {
         while(this.var_572.length > 0)
         {
            (this.var_572.pop() as IAssetLibrary).dispose();
         }
         while(this.var_28.length > 0)
         {
            (this.var_28.pop() as IAssetLibrary).dispose();
         }
      }
      
      override public function dispose() : void
      {
         var _loc1_:* = 0;
         var _loc2_:* = null;
         var _loc3_:int = 0;
         if(!disposed)
         {
            super.dispose();
            _loc1_ = uint(this.var_28.length);
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
               _loc2_ = this.var_28.pop();
               _loc2_.dispose();
               _loc3_++;
            }
         }
      }
      
      private function loadEventHandler(param1:LibraryLoaderEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:int = 0;
         if(param1.type == LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE)
         {
            _loc2_ = param1.target as LibraryLoader;
            _loc4_ = 0;
            while(_loc4_ < this.var_572.length)
            {
               _loc3_ = this.var_572[_loc4_] as IAssetLibrary;
               if(_loc3_.url == _loc2_.url)
               {
                  this.var_572.splice(_loc4_,1);
                  break;
               }
               _loc4_++;
            }
            this.var_28.push(_loc3_);
            _loc2_.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE,this.loadEventHandler);
            _loc2_.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR,this.loadEventHandler);
            _loc2_.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_PROGRESS,this.loadEventHandler);
            if(this.var_572.length == 0)
            {
               dispatchEvent(new Event(AssetLibrary.const_695));
            }
         }
      }
      
      public function hasAssetLibrary(param1:String) : Boolean
      {
         var _loc3_:* = null;
         var _loc2_:uint = this.var_28.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = this.var_28[_loc4_];
            if(_loc3_.name == param1)
            {
               return true;
            }
            _loc4_++;
         }
         return false;
      }
      
      public function getAssetLibraryByName(param1:String) : IAssetLibrary
      {
         var _loc3_:* = null;
         var _loc2_:uint = this.var_28.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = this.var_28[_loc4_];
            if(_loc3_.name == param1)
            {
               return _loc3_;
            }
            _loc4_++;
         }
         return null;
      }
      
      public function getAssetLibraryByUrl(param1:String) : IAssetLibrary
      {
         var _loc3_:* = null;
         var _loc2_:uint = this.var_28.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = this.var_28[_loc4_];
            if(_loc3_.url == param1)
            {
               return _loc3_;
            }
            _loc4_++;
         }
         return null;
      }
      
      public function addAssetLibrary(param1:IAssetLibrary) : void
      {
         if(this.var_28.indexOf(param1) == -1)
         {
            this.var_28.push(param1);
         }
      }
      
      public function loadAssetFromFile(param1:String, param2:URLRequest, param3:String = null) : AssetLoaderStruct
      {
         return this.var_481.loadAssetFromFile(param1,param2,param3);
      }
      
      public function getAssetByName(param1:String) : IAsset
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc2_:uint = this.var_28.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc2_)
         {
            _loc3_ = this.var_28[_loc5_];
            _loc4_ = _loc3_.getAssetByName(param1);
            if(_loc4_ != null)
            {
               return _loc4_;
            }
            _loc5_++;
         }
         return null;
      }
      
      public function getAssetsByName(param1:String) : Array
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc2_:* = [];
         for each(_loc4_ in this.var_28)
         {
            _loc3_ = _loc4_.getAssetByName(param1);
            if(_loc3_ != null)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function getAssetByContent(param1:Object) : IAsset
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc2_:uint = this.var_28.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc2_)
         {
            _loc3_ = this.var_28[_loc5_];
            _loc4_ = _loc3_.getAssetByContent(param1);
            if(_loc4_ != null)
            {
               return _loc4_;
            }
            _loc5_++;
         }
         return null;
      }
      
      public function getAssetByIndex(param1:uint) : IAsset
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:uint = this.var_28.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc2_ += IAssetLibrary(this.var_28[_loc5_]).numAssets;
            if(_loc2_ <= param1)
            {
               return IAssetLibrary(this.var_28[_loc5_]).getAssetByIndex(param1 - _loc3_);
            }
            _loc3_ = uint(_loc2_);
            _loc5_++;
         }
         return null;
      }
      
      public function getAssetIndex(param1:IAsset) : int
      {
         var _loc3_:* = null;
         var _loc2_:uint = this.var_28.length;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         while(_loc6_ < _loc2_)
         {
            _loc3_ = this.var_28[_loc6_];
            _loc5_ = _loc3_.getAssetIndex(param1);
            if(_loc5_ != -1)
            {
               return _loc4_ + _loc5_;
            }
            _loc4_ += _loc3_.numAssets;
            _loc6_++;
         }
         return -1;
      }
      
      public function hasAsset(param1:String) : Boolean
      {
         var _loc3_:* = null;
         var _loc2_:uint = this.var_28.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = this.var_28[_loc4_];
            if(_loc3_.hasAsset(param1))
            {
               return true;
            }
            _loc4_++;
         }
         return false;
      }
      
      public function setAsset(param1:String, param2:IAsset, param3:Boolean = true) : Boolean
      {
         return this.var_481.setAsset(param1,param2,param3);
      }
      
      public function createAsset(param1:String, param2:AssetTypeDeclaration) : IAsset
      {
         return this.var_481.createAsset(param1,param2);
      }
      
      public function removeAsset(param1:IAsset) : IAsset
      {
         var _loc3_:* = null;
         var _loc2_:uint = this.var_28.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = this.var_28[_loc4_];
            if(_loc3_.removeAsset(param1) == param1)
            {
               return param1;
            }
            _loc4_++;
         }
         return null;
      }
      
      public function registerAssetTypeDeclaration(param1:AssetTypeDeclaration, param2:Boolean = true) : Boolean
      {
         return this.var_481.registerAssetTypeDeclaration(param1,param2);
      }
      
      public function getAssetTypeDeclarationByMimeType(param1:String, param2:Boolean = true) : AssetTypeDeclaration
      {
         var _loc3_:* = 0;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:int = 0;
         if(param2)
         {
            return this.var_481.getAssetTypeDeclarationByMimeType(param1,true);
         }
         _loc3_ = uint(this.var_28.length);
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc4_ = this.var_28[_loc6_];
            _loc5_ = _loc4_.getAssetTypeDeclarationByMimeType(param1,false);
            if(_loc5_ != null)
            {
               return _loc5_;
            }
            _loc6_++;
         }
         return null;
      }
      
      public function getAssetTypeDeclarationByClass(param1:Class, param2:Boolean = true) : AssetTypeDeclaration
      {
         var _loc3_:* = 0;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:int = 0;
         if(param2)
         {
            return this.var_481.getAssetTypeDeclarationByClass(param1,true);
         }
         _loc3_ = uint(this.var_28.length);
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc4_ = this.var_28[_loc6_];
            _loc5_ = _loc4_.getAssetTypeDeclarationByClass(param1,false);
            if(_loc5_ != null)
            {
               return _loc5_;
            }
            _loc6_++;
         }
         return null;
      }
      
      public function getAssetTypeDeclarationByFileName(param1:String, param2:Boolean = true) : AssetTypeDeclaration
      {
         var _loc3_:* = 0;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:int = 0;
         if(param2)
         {
            return this.var_481.getAssetTypeDeclarationByFileName(param1,true);
         }
         _loc3_ = uint(this.var_28.length);
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc4_ = this.var_28[_loc6_];
            _loc5_ = _loc4_.getAssetTypeDeclarationByFileName(param1,false);
            if(_loc5_ != null)
            {
               return _loc5_;
            }
            _loc6_++;
         }
         return null;
      }
      
      private function getNumAssets() : uint
      {
         var _loc1_:* = 0;
         var _loc2_:uint = this.var_28.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ += IAssetLibrary(this.var_28[_loc3_]).numAssets;
            _loc3_++;
         }
         return _loc1_;
      }
      
      private function getAssetNameArray() : Array
      {
         var _loc1_:Array = new Array();
         var _loc2_:uint = this.var_28.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = _loc1_.concat(IAssetLibrary(this.var_28[_loc3_]).nameArray);
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function getManifests() : Array
      {
         var _loc1_:Array = new Array();
         var _loc2_:int = this.var_28.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_.push(IAssetLibrary(this.var_28[_loc3_]).manifest);
            _loc3_++;
         }
         return _loc1_;
      }
   }
}
