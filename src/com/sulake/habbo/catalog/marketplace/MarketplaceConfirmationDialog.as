package com.sulake.habbo.catalog.marketplace
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.localization.ILocalization;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IFrameWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.room.IGetImageListener;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.ImageResult;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   
   public class MarketplaceConfirmationDialog implements IGetImageListener
   {
       
      
      private var var_755:MarketPlaceLogic;
      
      private var _catalog:IHabboCatalog;
      
      private var _roomEngine:IRoomEngine;
      
      private var _window:IFrameWindow;
      
      private var var_91:MarketPlaceOfferData;
      
      public function MarketplaceConfirmationDialog(param1:MarketPlaceLogic, param2:IHabboCatalog, param3:IRoomEngine)
      {
         super();
         this.var_755 = param1;
         this._catalog = param2;
         this._roomEngine = param3;
      }
      
      public function dispose() : void
      {
         this.var_755 = null;
         this._catalog = null;
         this._roomEngine = null;
         if(this._window)
         {
            this._window.dispose();
            this._window = null;
         }
         this.var_91 = null;
      }
      
      public function showConfirmation(param1:int, param2:MarketPlaceOfferData) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         if(!param2)
         {
            return;
         }
         this.var_91 = param2;
         if(!this.var_755 || !this._catalog || !this._catalog.localization)
         {
            return;
         }
         if(this._window)
         {
            this._window.dispose();
         }
         this._window = this.createWindow("marketplace_purchase_confirmation") as IFrameWindow;
         this._window.procedure = this.eventHandler;
         this._window.center();
         var _loc3_:ITextWindow = this._window.findChildByName("header_text") as ITextWindow;
         if(_loc3_)
         {
            if(param1 == this.var_755.const_1970)
            {
               _loc3_.text = "${catalog.marketplace.confirm_header}";
            }
            if(param1 == this.var_755.const_2138)
            {
               _loc3_.text = "${catalog.marketplace.confirm_higher_header}";
            }
         }
         _loc3_ = this._window.findChildByName("item_name") as ITextWindow;
         if(_loc3_)
         {
            _loc3_.text = "${" + this.var_755.getNameLocalizationKey(param2) + "}";
         }
         _loc3_ = this._window.findChildByName("item_price") as ITextWindow;
         if(_loc3_)
         {
            _loc4_ = this._catalog.localization.getKey("catalog.marketplace.confirm_price");
            _loc4_ = _loc4_.replace("%price%",this.var_91.price);
            _loc3_.text = _loc4_;
         }
         _loc3_ = this._window.findChildByName("item_average_price") as ITextWindow;
         if(_loc3_)
         {
            _loc5_ = this._catalog.localization.getLocalization("catalog.marketplace.offer_details.average_price");
            if(_loc5_)
            {
               _loc4_ = _loc5_.raw;
               _loc4_ = _loc4_.replace("%days%",this.var_755.averagePricePeriod.toString());
               _loc6_ = this.var_91.averagePrice == 0 ? " - " : this.var_91.averagePrice.toString();
               _loc4_ = _loc4_.replace("%average%",_loc6_);
               _loc3_.text = _loc4_;
            }
            else
            {
               _loc3_.visible = false;
            }
         }
         _loc3_ = this._window.findChildByName("offer_count") as ITextWindow;
         if(_loc3_)
         {
            _loc5_ = this._catalog.localization.getLocalization("catalog.marketplace.offer_details.offer_count");
            if(_loc5_)
            {
               _loc4_ = _loc5_.raw;
               _loc4_ = _loc4_.replace("%count%",this.var_91.offerCount);
               _loc3_.text = _loc4_;
            }
            else
            {
               _loc3_.visible = false;
            }
         }
         this.setImage();
      }
      
      private function setImage() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         if(!this.var_91 || !this._window || !this._roomEngine)
         {
            return;
         }
         if(!this.var_91.image)
         {
            if(this.var_91.furniType == 1)
            {
               _loc1_ = this._roomEngine.getFurnitureIcon(this.var_91.furniId,this);
            }
            else if(this.var_91.furniType == 2)
            {
               _loc1_ = this._roomEngine.getWallItemIcon(this.var_91.furniId,this);
            }
            if(_loc1_ && _loc1_.data)
            {
               this.var_91.image = _loc1_.data as BitmapData;
               this.var_91.imageCallback = _loc1_.id;
            }
         }
         if(this.var_91.image != null)
         {
            _loc2_ = this._window.findChildByName("item_image") as IBitmapWrapperWindow;
            if(_loc2_)
            {
               if(_loc2_.bitmap)
               {
                  _loc2_.bitmap.dispose();
                  _loc2_.bitmap = null;
               }
               _loc2_.bitmap = new BitmapData(_loc2_.width,_loc2_.height,true,0);
               _loc2_.bitmap.draw(this.var_91.image,new Matrix(1,0,0,1,(_loc2_.width - this.var_91.image.width) / 2,(_loc2_.height - this.var_91.image.height) / 2));
            }
         }
      }
      
      private function eventHandler(param1:WindowEvent, param2:IWindow) : void
      {
         if(!param1 || !param2)
         {
            return;
         }
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         switch(param2.name)
         {
            case "buy_button":
               this._catalog.buyMarketPlaceOffer(this.var_91.offerId);
               this.hide();
               break;
            case "header_button_close":
            case "cancel_button":
               this.hide();
         }
      }
      
      private function hide() : void
      {
         if(this._window)
         {
            this._window.dispose();
            this._window = null;
         }
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         if(this.var_91 && this.var_91.imageCallback == param1)
         {
            this.var_91.image = param2;
            this.setImage();
         }
      }
      
      private function createWindow(param1:String) : IWindow
      {
         if(!this._catalog || !this._catalog.assets || !this._catalog.windowManager)
         {
            return null;
         }
         var _loc2_:XmlAsset = this._catalog.assets.getAssetByName(param1) as XmlAsset;
         if(!_loc2_ || !_loc2_.content)
         {
            return null;
         }
         var _loc3_:XML = _loc2_.content as XML;
         if(!_loc3_)
         {
            return null;
         }
         return this._catalog.windowManager.buildFromXML(_loc3_);
      }
   }
}
