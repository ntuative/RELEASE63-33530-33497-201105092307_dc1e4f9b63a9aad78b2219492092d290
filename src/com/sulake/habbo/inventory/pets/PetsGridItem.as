package com.sulake.habbo.inventory.pets
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.PetData;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class PetsGridItem
   {
       
      
      private var _petData:PetData;
      
      private var _window:IWindowContainer;
      
      private var var_1503:IWindow;
      
      private var _isSelected:Boolean;
      
      private var var_1385:PetsView;
      
      private var var_1386:Boolean;
      
      private const const_1514:int = 8947848;
      
      private const const_1511:int = 13421772;
      
      public function PetsGridItem(param1:PetsView, param2:PetData, param3:IHabboWindowManager, param4:IAssetLibrary, param5:IAvatarRenderManager)
      {
         super();
         if(param1 == null || param2 == null || param3 == null || param4 == null || param5 == null)
         {
            return;
         }
         this.var_1385 = param1;
         this._petData = param2;
         var _loc6_:XmlAsset = param4.getAssetByName("inventory_thumb_xml") as XmlAsset;
         if(_loc6_ == null || _loc6_.content == null)
         {
            return;
         }
         this._window = param3.buildFromXML(_loc6_.content as XML) as IWindowContainer;
         this.var_1503 = this._window.findChildByTag("BG_COLOR");
         this._window.procedure = this.eventHandler;
         var _loc7_:BitmapData = param1.getPetImage(param2.type,param2.breed,param2.color,3,false);
         var _loc8_:IBitmapWrapperWindow = this._window.findChildByName("bitmap") as IBitmapWrapperWindow;
         var _loc9_:BitmapData = new BitmapData(_loc8_.width,_loc8_.height);
         _loc9_.fillRect(_loc9_.rect,0);
         _loc9_.copyPixels(_loc7_,_loc7_.rect,new Point(_loc9_.width / 2 - _loc7_.width / 2,_loc9_.height / 2 - _loc7_.height / 2));
         _loc8_.bitmap = _loc9_;
         this.setSelected(false);
      }
      
      private function eventHandler(param1:WindowEvent, param2:IWindow) : void
      {
         switch(param1.type)
         {
            case WindowMouseEvent.const_42:
               this.var_1385.setSelectedGridItem(this);
               this.var_1386 = true;
               break;
            case WindowMouseEvent.const_52:
               this.var_1386 = false;
               break;
            case WindowMouseEvent.const_25:
               if(this.var_1386)
               {
                  this.var_1386 = false;
                  this.var_1385.placePetToRoom(this._petData.id,true);
               }
         }
      }
      
      public function setSelected(param1:Boolean) : void
      {
         if(this._isSelected == param1)
         {
            return;
         }
         this._isSelected = param1;
         if(this._window == null)
         {
            return;
         }
         if(this.var_1503 == null)
         {
            return;
         }
         this.var_1503.color = !!this._isSelected ? uint(this.const_1514) : uint(this.const_1511);
      }
      
      public function dispose() : void
      {
         this.var_1385 = null;
         if(this._window != null)
         {
            this._window.dispose();
            this._window = null;
         }
      }
      
      public function get window() : IWindow
      {
         return this._window;
      }
      
      public function get pet() : PetData
      {
         return this._petData;
      }
   }
}
