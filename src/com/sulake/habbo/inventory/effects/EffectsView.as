package com.sulake.habbo.inventory.effects
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IButtonWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.inventory.IInventoryView;
   import com.sulake.habbo.inventory.common.IThumbListDataProvider;
   import com.sulake.habbo.inventory.common.ThumbListManager;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class EffectsView implements IInventoryView
   {
       
      
      private var _windowManager:IHabboWindowManager;
      
      private var _assetLibrary:IAssetLibrary;
      
      private var _view:IWindowContainer;
      
      private var var_65:EffectsModel;
      
      private var var_835:ThumbListManager;
      
      private var var_836:ThumbListManager;
      
      private var _disposed:Boolean = false;
      
      public function EffectsView(param1:EffectsModel, param2:IHabboWindowManager, param3:IAssetLibrary, param4:IHabboLocalizationManager, param5:IThumbListDataProvider, param6:IThumbListDataProvider)
      {
         super();
         this.var_65 = param1;
         this._assetLibrary = param3;
         this._windowManager = param2;
         var _loc7_:IAsset = this._assetLibrary.getAssetByName("inventory_effects_xml");
         var _loc8_:XmlAsset = XmlAsset(_loc7_);
         this._view = IWindowContainer(this._windowManager.buildFromXML(XML(_loc8_.content)));
         this._view.visible = false;
         this._view.procedure = this.windowEventProc;
         this.var_835 = new ThumbListManager(this._assetLibrary,param5,"thumb_bg_png","thumb_bg_selected_png",this.getActiveThumbListImageWidth(),this.getActiveThumbListImageHeight());
         this.var_836 = new ThumbListManager(this._assetLibrary,param6,"thumb_bg_png","thumb_bg_selected_png",this.getActiveThumbListImageWidth(),this.getActiveThumbListImageHeight());
         var _loc9_:IBitmapWrapperWindow = this._view.findChildByName("active_items_image") as IBitmapWrapperWindow;
         _loc9_.procedure = this.activeThumbListEventProc;
         var _loc10_:IBitmapWrapperWindow = this._view.findChildByName("inactive_items_image") as IBitmapWrapperWindow;
         _loc10_.procedure = this.inactiveThumbListEventProc;
         this._view.procedure = this.windowEventProc;
      }
      
      public function get disposed() : Boolean
      {
         return this._disposed;
      }
      
      public function dispose() : void
      {
         if(!this._disposed)
         {
            this._windowManager = null;
            this.var_65 = null;
            this._view = null;
            if(this.var_835 != null)
            {
               this.var_835.dispose();
               this.var_835 = null;
            }
            if(this.var_836 != null)
            {
               this.var_836.dispose();
               this.var_836 = null;
            }
            this._disposed = true;
         }
      }
      
      public function getActiveThumbListImageWidth() : int
      {
         var _loc1_:IBitmapWrapperWindow = this._view.findChildByName("active_items_image") as IBitmapWrapperWindow;
         if(_loc1_ == null)
         {
            return 0;
         }
         return _loc1_.width;
      }
      
      public function getActiveThumbListImageHeight() : int
      {
         var _loc1_:IBitmapWrapperWindow = this._view.findChildByName("active_items_image") as IBitmapWrapperWindow;
         if(_loc1_ == null)
         {
            return 0;
         }
         return _loc1_.height;
      }
      
      public function getInactiveThumbListImageWidth() : int
      {
         var _loc1_:IBitmapWrapperWindow = this._view.findChildByName("inactive_items_image") as IBitmapWrapperWindow;
         if(_loc1_ == null)
         {
            return 0;
         }
         return _loc1_.width;
      }
      
      public function getInactiveThumbListImageHeight() : int
      {
         var _loc1_:IBitmapWrapperWindow = this._view.findChildByName("inactive_items_image") as IBitmapWrapperWindow;
         if(_loc1_ == null)
         {
            return 0;
         }
         return _loc1_.height;
      }
      
      public function getWindowContainer() : IWindowContainer
      {
         if(this._view == null)
         {
            return null;
         }
         if(this._view.disposed)
         {
            return null;
         }
         return this._view;
      }
      
      public function updateListViews() : void
      {
         if(this._view == null)
         {
            return;
         }
         if(this._view.disposed)
         {
            return;
         }
         this.var_836.updateImageFromList();
         this.var_835.updateImageFromList();
         var _loc1_:IBitmapWrapperWindow = this._view.findChildByName("inactive_items_image") as IBitmapWrapperWindow;
         var _loc2_:BitmapData = this.var_836.getListImage();
         _loc1_.bitmap = _loc2_;
         _loc1_.width = _loc2_.width;
         _loc1_.height = _loc2_.height;
         _loc1_.invalidate();
         var _loc3_:IBitmapWrapperWindow = this._view.findChildByName("active_items_image") as IBitmapWrapperWindow;
         var _loc4_:BitmapData = this.var_835.getListImage();
         _loc3_.bitmap = _loc4_;
         _loc3_.width = _loc4_.width;
         _loc3_.height = _loc4_.height;
         _loc3_.invalidate();
      }
      
      public function updateActionView() : void
      {
         if(this._view == null)
         {
            return;
         }
         if(this._view.disposed)
         {
            return;
         }
         var _loc1_:IButtonWindow = this._view.findChildByName("activateEffect_button") as IButtonWindow;
         var _loc2_:ITextWindow = this._view.findChildByName("effectDescriptionText") as ITextWindow;
         if(_loc1_ == null)
         {
            return;
         }
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:Effect = this.var_65.getSelectedEffect(-1);
         if(_loc3_ == null)
         {
            _loc1_.disable();
            this.setEffectDescriptionImage(null);
            _loc2_.text = "${inventory.effects.defaultdescription}";
         }
         else if(_loc3_.isActive)
         {
            _loc1_.disable();
            this.setEffectDescriptionImage(_loc3_.iconImage);
            _loc2_.text = "${inventory.effects.active}";
            this._windowManager.registerLocalizationParameter("inventory.effects.active","timeleft",this.convertSecondsToTime(_loc3_.secondsLeft));
            this._windowManager.registerLocalizationParameter("inventory.effects.active","duration",this.convertSecondsToTime(_loc3_.duration));
            this._windowManager.registerLocalizationParameter("inventory.effects.active","itemcount",String(_loc3_.effectsInInventory));
         }
         else
         {
            _loc1_.enable();
            this.setEffectDescriptionImage(_loc3_.iconImage);
            _loc2_.text = "${inventory.effects.inactive}";
            this._windowManager.registerLocalizationParameter("inventory.effects.inactive","duration",this.convertSecondsToTime(_loc3_.duration));
            this._windowManager.registerLocalizationParameter("inventory.effects.inactive","itemcount",String(_loc3_.effectsInInventory));
         }
      }
      
      private function setEffectDescriptionImage(param1:BitmapData) : void
      {
         if(this._view == null)
         {
            return;
         }
         if(this._view.disposed)
         {
            return;
         }
         var _loc2_:IBitmapWrapperWindow = this._view.findChildByName("effectDescriptionImage") as IBitmapWrapperWindow;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.bitmap == null)
         {
            _loc2_.bitmap = new BitmapData(_loc2_.width,_loc2_.height,false);
         }
         if(param1 == null)
         {
            param1 = new BitmapData(_loc2_.width,_loc2_.height);
         }
         var _loc3_:Point = new Point((_loc2_.width - param1.width) / 2,(_loc2_.height - param1.height) / 2);
         _loc2_.bitmap.copyPixels(param1,param1.rect,_loc3_,null,null,false);
         _loc2_.invalidate();
      }
      
      private function convertSecondsToTime(param1:int) : String
      {
         var _loc2_:int = Math.floor(param1 / 60 / 60);
         var _loc3_:int = Math.floor((param1 - _loc2_ * 60 * 60) / 60);
         var _loc4_:int = param1 - _loc2_ * 60 * 60 - _loc3_ * 60;
         var _loc5_:* = "";
         if(_loc2_ > 0)
         {
            _loc5_ = _loc2_ + ":";
         }
         _loc5_ = _loc3_ < 10 ? _loc5_ + "0" + _loc3_ : _loc5_ + _loc3_;
         _loc5_ += ":";
         return _loc4_ < 10 ? _loc5_ + "0" + _loc4_ : _loc5_ + _loc4_;
      }
      
      private function activeThumbListEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc5_:* = null;
         if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            _loc3_ = new Point(WindowMouseEvent(param1).localX,WindowMouseEvent(param1).localY);
            _loc4_ = this.var_835.resolveIndexFromImageLocation(_loc3_);
            _loc5_ = this.var_65.getItemInIndex(_loc4_,1);
            if(_loc5_ != null)
            {
               this.var_65.toggleEffectSelected(_loc5_.type);
            }
         }
      }
      
      private function inactiveThumbListEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc5_:* = null;
         if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            _loc3_ = new Point(WindowMouseEvent(param1).localX,WindowMouseEvent(param1).localY);
            _loc4_ = this.var_836.resolveIndexFromImageLocation(_loc3_);
            _loc5_ = this.var_65.getItemInIndex(_loc4_,0);
            if(_loc5_ != null)
            {
               this.var_65.toggleEffectSelected(_loc5_.type);
            }
         }
      }
      
      private function windowEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:* = null;
         if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            if(param2.name == "activateEffect_button")
            {
               _loc3_ = this.var_65.getSelectedEffect(0);
               if(_loc3_ != null)
               {
                  this.var_65.requestEffectActivated(_loc3_.type);
               }
            }
         }
      }
   }
}
