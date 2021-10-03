package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.viewer.IDragAndDropDoneReceiver;
   import com.sulake.habbo.catalog.viewer.Offer;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetInitPurchaseEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetUpdateRoomPreviewEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.WidgetEvent;
   import com.sulake.habbo.room.IGetImageListener;
   import com.sulake.habbo.room.ImageResult;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class RoomPreviewCatalogWidget extends CatalogWidget implements ICatalogWidget, IGetImageListener, IDragAndDropDoneReceiver
   {
       
      
      private var var_2036:int = -1;
      
      private var var_2037:int = -1;
      
      private var var_393:BitmapData = null;
      
      private var _imageStoreWindow:BitmapData = null;
      
      private var var_682:Object;
      
      private var var_91:Offer;
      
      public function RoomPreviewCatalogWidget(param1:IWindowContainer)
      {
         super(param1);
      }
      
      override public function dispose() : void
      {
         if(this.var_393 != null)
         {
            this.var_393.dispose();
            this.var_393 = null;
         }
         if(this._imageStoreWindow != null)
         {
            this._imageStoreWindow.dispose();
            this._imageStoreWindow = null;
         }
         events.removeEventListener(WidgetEvent.CWE_UPDATE_ROOM_PREVIEW,this.onUpdateRoomPreview);
         super.dispose();
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         var _loc1_:IBitmapWrapperWindow = window.getChildByName("catalog_floor_preview_example") as IBitmapWrapperWindow;
         _loc1_.procedure = this.eventProc;
         events.addEventListener(WidgetEvent.CWE_UPDATE_ROOM_PREVIEW,this.onUpdateRoomPreview);
         events.addEventListener(WidgetEvent.CWE_SELECT_PRODUCT,this.onPreviewProduct);
         return true;
      }
      
      private function onPreviewProduct(param1:SelectProductEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         this.var_91 = param1.offer;
      }
      
      private function eventProc(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == WindowMouseEvent.const_52)
         {
            this.var_682 = null;
         }
         else if(param1.type == WindowMouseEvent.const_42)
         {
            if(param2 == null)
            {
               return;
            }
            this.var_682 = param2;
         }
         else if(param1.type == WindowMouseEvent.const_25 && this.var_682 != null && this.var_682 == param2)
         {
            if(this.var_91)
            {
               (page.viewer.catalog as HabboCatalog).requestSelectedItemToMover(this,this.var_91);
               this.var_682 = null;
            }
         }
         else if(param1.type == WindowMouseEvent.const_52)
         {
            this.var_682 == null;
         }
         else if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            this.var_682 == null;
         }
         else if(param1.type == WindowMouseEvent.const_169)
         {
            this.var_682 = null;
         }
      }
      
      public function onDragAndDropDone(param1:Boolean) : void
      {
         if(disposed)
         {
            return;
         }
         if(param1)
         {
            events.dispatchEvent(new CatalogWidgetInitPurchaseEvent(false));
         }
      }
      
      public function stopDragAndDrop() : void
      {
      }
      
      private function onUpdateRoomPreview(param1:CatalogWidgetUpdateRoomPreviewEvent) : void
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc3_:ImageResult = page.viewer.roomEngine.getRoomImage(param1.floorType,param1.wallType,param1.landscapeType,param1.tileSize,this,"window_romantic_wide");
         var _loc4_:ImageResult = page.viewer.roomEngine.getGenericRoomObjectImage("window_romantic_wide","",new Vector3d(180,0,0),param1.tileSize,this);
         if(_loc3_ != null && _loc4_ != null)
         {
            this.var_2036 = _loc3_.id;
            this.var_2037 = _loc4_.id;
            _loc5_ = _loc3_.data as BitmapData;
            _loc6_ = _loc4_.data as BitmapData;
            if(this.var_393 != null)
            {
               this.var_393.dispose();
            }
            if(this._imageStoreWindow != null)
            {
               this._imageStoreWindow.dispose();
            }
            this.var_393 = _loc5_;
            this._imageStoreWindow = _loc6_;
            this.setRoomImage(_loc5_,_loc6_);
         }
      }
      
      private function setRoomImage(param1:BitmapData, param2:BitmapData) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         if(param1 != null && param2 != null && true)
         {
            _loc3_ = new Point(param1.width / 2 + 4 + 19,param1.height / 2 - param2.height / 2 - 24 + 10);
            _loc4_ = new BitmapData(param1.width,param1.height,param1.transparent);
            _loc4_.copyPixels(param1,param1.rect,new Point(0,0),null,null,true);
            _loc4_.copyPixels(param2,param2.rect,_loc3_,null,null,true);
            _loc5_ = window.getChildByName("catalog_floor_preview_example") as IBitmapWrapperWindow;
            if(_loc5_ != null)
            {
               if(_loc5_.bitmap == null)
               {
                  _loc5_.bitmap = new BitmapData(_loc5_.width,_loc5_.height,true,16777215);
               }
               _loc5_.bitmap.fillRect(_loc5_.bitmap.rect,16777215);
               _loc6_ = (_loc5_.width - _loc4_.width) / 2 - 20;
               _loc7_ = (_loc5_.height - _loc4_.height) / 2;
               _loc5_.bitmap.copyPixels(_loc4_,_loc4_.rect,new Point(_loc6_,_loc7_),null,null,true);
               _loc5_.invalidate();
            }
            _loc4_.dispose();
         }
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         if(disposed)
         {
            return;
         }
         switch(param1)
         {
            case this.var_2036:
               this.var_2036 = 0;
               if(this.var_393 != null)
               {
                  this.var_393.dispose();
               }
               this.var_393 = param2;
               break;
            case this.var_2037:
               this.var_2037 = 0;
               if(this._imageStoreWindow != null)
               {
                  this._imageStoreWindow.dispose();
               }
               this._imageStoreWindow = param2;
         }
         if(this.var_393 != null && this._imageStoreWindow != null)
         {
            this.setRoomImage(this.var_393,this._imageStoreWindow);
         }
      }
   }
}
