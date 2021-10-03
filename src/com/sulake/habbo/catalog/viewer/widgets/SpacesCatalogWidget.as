package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.localization.ICoreLocalizationManager;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IButtonWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.viewer.IProduct;
   import com.sulake.habbo.catalog.viewer.Offer;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetUpdateRoomPreviewEvent;
   
   public class SpacesCatalogWidget extends CatalogWidget implements ICatalogWidget
   {
      
      private static const const_226:String = "floor";
      
      private static const const_227:String = "wallpaper";
      
      private static const TYPE_LANDSCAPE:String = "landscape";
       
      
      private var var_182:XML;
      
      private var var_1412:Array;
      
      private var _activeWallpaperPatterns:Array;
      
      private var var_421:int = 0;
      
      private var var_424:int = 0;
      
      private var var_921:int = 0;
      
      private var var_1413:String = "default";
      
      private var var_1411:Array;
      
      private var var_924:Array;
      
      private var var_423:int = 0;
      
      private var var_505:int = 0;
      
      private var var_923:int = 0;
      
      private var _floorType:String = "default";
      
      private var var_1414:Array;
      
      private var var_925:Array;
      
      private var var_422:int = 0;
      
      private var var_506:int = 0;
      
      private var var_922:int = 0;
      
      private var var_1415:String = "1.1";
      
      public function SpacesCatalogWidget(param1:IWindowContainer)
      {
         this.var_1412 = [];
         this._activeWallpaperPatterns = [];
         this.var_1411 = [];
         this.var_924 = [];
         this.var_1414 = [];
         this.var_925 = [];
         super(param1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      override public function init() : Boolean
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:Boolean = false;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc12_:* = null;
         if(!super.init())
         {
            return false;
         }
         var _loc1_:XmlAsset = page.viewer.catalog.assets.getAssetByName("configuration_catalog_spaces") as XmlAsset;
         if(_loc1_ != null)
         {
            this.var_182 = _loc1_.content as XML;
            for each(_loc2_ in page.offers)
            {
               _loc4_ = _loc2_.productContainer.firstProduct;
               _loc5_ = _loc2_.localizationId;
               _loc6_ = _loc5_.split(" ")[0];
               _loc7_ = _loc5_.split(" ")[1];
               _loc8_ = false;
               switch(_loc4_.furnitureData.name)
               {
                  case "floor":
                     for each(_loc9_ in this.var_182.floors.pattern)
                     {
                        this.var_924.push(String(_loc9_.@id));
                        this.var_1411.push(_loc2_);
                     }
                     break;
                  case "wallpaper":
                     for each(_loc10_ in this.var_182.walls.pattern)
                     {
                        if(_loc10_.@id == _loc7_)
                        {
                           this._activeWallpaperPatterns.push(_loc7_);
                           _loc8_ = true;
                        }
                     }
                     if(_loc8_)
                     {
                        this.var_1412.push(_loc2_);
                     }
                     else
                     {
                        Logger.log("[SpacesCatalogWidget] Could not find wallpaper pattern configuration! " + [_loc2_.localizationId,_loc4_.furnitureData.name]);
                     }
                     break;
                  case "landscape":
                     for each(_loc11_ in this.var_182.landscapes.pattern)
                     {
                        if(_loc11_.@id == _loc7_)
                        {
                           this.var_925.push(_loc7_);
                           _loc8_ = true;
                        }
                     }
                     if(_loc8_)
                     {
                        this.var_1414.push(_loc2_);
                     }
                     else
                     {
                        Logger.log("[SpacesCatalogWidget] Could not find landscape pattern configuration! " + [_loc2_.localizationId,_loc4_.furnitureData.name]);
                     }
                     break;
                  default:
                     Logger.log("[SpacesCatalogWidget] : " + _loc4_.furnitureData.name);
                     break;
               }
            }
            _loc3_ = 0;
            while(_loc3_ < _window.numChildren)
            {
               _loc12_ = _window.getChildAt(_loc3_);
               if(_loc12_ is IButtonWindow)
               {
                  _loc12_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onClick);
               }
               _loc3_++;
            }
            this.changePattern(const_227,0);
            this.changePattern(TYPE_LANDSCAPE,0);
            this.changePattern(const_226,0);
            this.updateConfiguration();
            events.dispatchEvent(new CatalogWidgetUpdateRoomPreviewEvent(this._floorType,this.var_1413,this.var_1415,64));
            return true;
         }
         return false;
      }
      
      private function onClick(param1:WindowMouseEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:IWindow = param1.target as IWindow;
         if(_loc2_ == null)
         {
            return;
         }
         switch(_loc2_.name)
         {
            case "ctlg_wall_pattern_prev":
               this.changePattern(const_227,-1);
               break;
            case "ctlg_wall_pattern_next":
               this.changePattern(const_227,1);
               break;
            case "ctlg_wall_color_prev":
               this.changeColor(const_227,-1);
               break;
            case "ctlg_wall_color_next":
               this.changeColor(const_227,1);
               break;
            case "ctlg_buy_wall":
               _loc3_ = this.var_1412[this.var_421];
               if(_loc3_ != null)
               {
                  (page.viewer.catalog as HabboCatalog).showPurchaseConfirmation(_loc3_,page.pageId,this.var_1413);
               }
               break;
            case "ctlg_floor_pattern_prev":
               this.changePattern(const_226,-1);
               break;
            case "ctlg_floor_pattern_next":
               this.changePattern(const_226,1);
               break;
            case "ctlg_floor_color_prev":
               this.changeColor(const_226,-1);
               break;
            case "ctlg_floor_color_next":
               this.changeColor(const_226,1);
               break;
            case "ctlg_buy_floor":
               _loc3_ = this.var_1411[this.var_423];
               if(_loc3_ != null)
               {
                  (page.viewer.catalog as HabboCatalog).showPurchaseConfirmation(_loc3_,page.pageId,this._floorType);
               }
               break;
            case "ctlg_landscape_pattern_next":
               this.changePattern(TYPE_LANDSCAPE,-1);
               break;
            case "ctlg_landscape_pattern_prev":
               this.changePattern(TYPE_LANDSCAPE,1);
               break;
            case "ctlg_landscape_color_prev":
               this.changeColor(TYPE_LANDSCAPE,-1);
               break;
            case "ctlg_landscape_color_next":
               this.changeColor(TYPE_LANDSCAPE,1);
               break;
            case "ctlg_buy_landscape":
               _loc3_ = this.var_1414[this.var_422];
               if(_loc3_ != null)
               {
                  (page.viewer.catalog as HabboCatalog).showPurchaseConfirmation(_loc3_,page.pageId,this.var_1415);
               }
               break;
            default:
               Logger.log("Spaces, unknown button: " + _loc2_.name);
         }
         this.updateConfiguration();
         events.dispatchEvent(new CatalogWidgetUpdateRoomPreviewEvent(this._floorType,this.var_1413,this.var_1415,64));
      }
      
      private function updateConfiguration() : void
      {
         var _loc1_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc6_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc13_:* = null;
         var _loc14_:* = null;
         var _loc2_:String = this._activeWallpaperPatterns[this.var_421];
         for each(_loc1_ in this.var_182.walls.pattern)
         {
            if(_loc1_.@id == _loc2_)
            {
               if(this.var_424 >= 0)
               {
                  _loc9_ = _loc1_.children()[this.var_424];
                  if(_loc9_ != null)
                  {
                     this.var_1413 = _loc9_.@id;
                  }
               }
            }
         }
         _loc3_ = this.var_1412[this.var_421];
         _loc4_ = (page.viewer.catalog as HabboCatalog).localization;
         if(_loc3_ != null)
         {
            _loc10_ = _window.findChildByName("ctlg_wall_price") as ITextWindow;
            if(_loc10_ != null)
            {
               _loc10_.caption = _loc4_.registerParameter("catalog.purchase.price.credits","credits",String(_loc3_.priceInCredits));
            }
         }
         var _loc5_:String = this.var_924[this.var_423];
         for each(_loc1_ in this.var_182.floors.pattern)
         {
            if(_loc1_.@id == _loc5_)
            {
               _loc11_ = _loc1_.children()[this.var_505];
               if(_loc11_ != null)
               {
                  this._floorType = _loc11_.@id;
               }
            }
         }
         _loc6_ = this.var_1411[this.var_423];
         if(_loc6_ != null)
         {
            _loc12_ = _window.findChildByName("ctlg_floor_price") as ITextWindow;
            if(_loc12_ != null)
            {
               _loc12_.caption = _loc4_.registerParameter("catalog.purchase.price.credits","credits",String(_loc6_.priceInCredits));
            }
         }
         var _loc7_:String = this.var_925[this.var_422];
         for each(_loc1_ in this.var_182.landscapes.pattern)
         {
            if(_loc1_.@id == _loc7_)
            {
               _loc13_ = _loc1_.children()[this.var_506];
               if(_loc13_ != null)
               {
                  this.var_1415 = _loc13_.@id;
               }
            }
         }
         _loc8_ = this.var_1414[this.var_422];
         if(_loc8_ != null)
         {
            _loc14_ = _window.findChildByName("ctlg_landscape_price") as ITextWindow;
            if(_loc14_ != null)
            {
               _loc14_.caption = _loc4_.registerParameter("catalog.purchase.price.credits","credits",String(_loc8_.priceInCredits));
            }
         }
      }
      
      private function changePattern(param1:String, param2:int) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         switch(param1)
         {
            case const_227:
               this.var_421 += param2;
               if(this.var_421 < 0)
               {
                  this.var_421 = this._activeWallpaperPatterns.length - 1;
               }
               if(this.var_421 == this._activeWallpaperPatterns.length)
               {
                  this.var_421 = 0;
               }
               this.var_424 = 0;
               this.var_921 = 0;
               _loc5_ = this._activeWallpaperPatterns[this.var_421];
               for each(_loc8_ in this.var_182.walls.pattern)
               {
                  if(_loc8_.@id == _loc5_)
                  {
                     this.var_921 = _loc8_.children().length();
                  }
               }
               _loc4_ = _window.findChildByName("ctlg_wall_color_prev") as IButtonWindow;
               _loc3_ = _window.findChildByName("ctlg_wall_color_next") as IButtonWindow;
               if(this.var_921 < 2)
               {
                  if(_loc4_ != null)
                  {
                     _loc4_.disable();
                  }
                  if(_loc3_ != null)
                  {
                     _loc3_.disable();
                  }
               }
               else
               {
                  if(_loc4_ != null)
                  {
                     _loc4_.enable();
                  }
                  if(_loc3_ != null)
                  {
                     _loc3_.enable();
                  }
               }
               break;
            case const_226:
               this.var_423 += param2;
               if(this.var_423 < 0)
               {
                  this.var_423 = this.var_924.length - 1;
               }
               if(this.var_423 >= this.var_924.length)
               {
                  this.var_423 = 0;
               }
               this.var_505 = 0;
               this.var_923 = 0;
               _loc6_ = this.var_924[this.var_423];
               for each(_loc9_ in this.var_182.floors.pattern)
               {
                  if(_loc9_.@id == _loc6_)
                  {
                     this.var_923 = _loc9_.children().length();
                  }
               }
               _loc4_ = _window.findChildByName("ctlg_floor_color_prev") as IButtonWindow;
               _loc3_ = _window.findChildByName("ctlg_floor_color_next") as IButtonWindow;
               if(this.var_923 < 2)
               {
                  if(_loc4_ != null)
                  {
                     _loc4_.disable();
                  }
                  if(_loc3_ != null)
                  {
                     _loc3_.disable();
                  }
               }
               else
               {
                  if(_loc4_ != null)
                  {
                     _loc4_.enable();
                  }
                  if(_loc3_ != null)
                  {
                     _loc3_.enable();
                  }
               }
               break;
            case TYPE_LANDSCAPE:
               this.var_422 += param2;
               if(this.var_422 < 0)
               {
                  this.var_422 = this.var_925.length - 1;
               }
               if(this.var_422 >= this.var_925.length)
               {
                  this.var_422 = 0;
               }
               this.var_506 = 0;
               this.var_922 = 0;
               _loc7_ = this.var_925[this.var_422];
               for each(_loc10_ in this.var_182.landscapes.pattern)
               {
                  if(_loc10_.@id == _loc7_)
                  {
                     this.var_922 = _loc10_.children().length();
                  }
               }
               _loc4_ = _window.findChildByName("ctlg_landscape_color_prev") as IButtonWindow;
               _loc3_ = _window.findChildByName("ctlg_landscape_color_next") as IButtonWindow;
               if(this.var_922 < 2)
               {
                  if(_loc4_ != null)
                  {
                     _loc4_.disable();
                  }
                  if(_loc3_ != null)
                  {
                     _loc3_.disable();
                  }
               }
               else
               {
                  if(_loc4_ != null)
                  {
                     _loc4_.enable();
                  }
                  if(_loc3_ != null)
                  {
                     _loc3_.enable();
                  }
               }
         }
      }
      
      private function changeColor(param1:String, param2:int) : void
      {
         switch(param1)
         {
            case const_227:
               this.var_424 += param2;
               if(this.var_424 < 0)
               {
                  if(this.var_921 > 0)
                  {
                     this.var_424 = this.var_921 - 1;
                  }
                  else
                  {
                     this.var_424 = 0;
                  }
               }
               if(this.var_424 >= this.var_921)
               {
                  this.var_424 = 0;
               }
               break;
            case const_226:
               this.var_505 += param2;
               if(this.var_505 < 0)
               {
                  if(this.var_923 > 0)
                  {
                     this.var_505 = this.var_923 - 1;
                  }
                  else
                  {
                     this.var_505 = 0;
                  }
               }
               if(this.var_505 >= this.var_923)
               {
                  this.var_505 = 0;
               }
               break;
            case TYPE_LANDSCAPE:
               this.var_506 += param2;
               if(this.var_506 < 0)
               {
                  if(this.var_922 > 0)
                  {
                     this.var_506 = this.var_922 - 1;
                  }
                  else
                  {
                     this.var_506 = 0;
                  }
               }
               if(this.var_506 >= this.var_922)
               {
                  this.var_506 = 0;
               }
         }
      }
   }
}
