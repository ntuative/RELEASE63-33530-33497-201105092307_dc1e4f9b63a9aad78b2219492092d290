package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IButtonWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.window.utils.IAlertDialog;
   import flash.ui.Keyboard;
   
   public class RedeemItemCodeCatalogWidget extends CatalogWidget implements ICatalogWidget
   {
       
      
      private var var_874:IButtonWindow;
      
      private var var_873:ITextFieldWindow;
      
      public function RedeemItemCodeCatalogWidget(param1:IWindowContainer)
      {
         super(param1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(this.var_874 != null)
         {
            this.var_874.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onRedeem);
            this.var_874 = null;
         }
         if(this.var_873 != null)
         {
            this.var_873.removeEventListener(WindowKeyboardEvent.const_175,this.windowKeyEventProcessor);
            this.var_873 = null;
         }
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         this.var_874 = _window.findChildByName("redeem") as IButtonWindow;
         if(this.var_874 != null)
         {
            this.var_874.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onRedeem);
         }
         this.var_873 = _window.findChildByName("voucher_code") as ITextFieldWindow;
         if(this.var_873 != null)
         {
            this.var_873.addEventListener(WindowKeyboardEvent.const_175,this.windowKeyEventProcessor);
         }
         return true;
      }
      
      private function onRedeem(param1:WindowMouseEvent) : void
      {
         this.redeem();
      }
      
      private function windowKeyEventProcessor(param1:WindowEvent = null, param2:IWindow = null) : void
      {
         var _loc3_:WindowKeyboardEvent = param1 as WindowKeyboardEvent;
         if(_loc3_.charCode == Keyboard.ENTER)
         {
            this.redeem();
         }
      }
      
      private function redeem() : void
      {
         var voucher:String = null;
         var input:ITextFieldWindow = _window.findChildByName("voucher_code") as ITextFieldWindow;
         if(input != null)
         {
            voucher = input.text;
            if(voucher.length > 0)
            {
               page.viewer.catalog.redeemVoucher(voucher);
               input.text = "";
            }
            else
            {
               page.viewer.catalog.windowManager.alert("${catalog.voucher.empty.title}","${catalog.voucher.empty.desc}",0,function(param1:IAlertDialog, param2:WindowEvent):void
               {
                  param1.dispose();
               });
            }
         }
      }
   }
}
