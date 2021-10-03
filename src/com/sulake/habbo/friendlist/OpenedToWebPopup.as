package com.sulake.habbo.friendlist
{
   import com.sulake.core.window.IWindowContainer;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class OpenedToWebPopup
   {
       
      
      private var _friendList:HabboFriendList;
      
      private var _alert:IWindowContainer;
      
      private var var_205:Timer;
      
      public function OpenedToWebPopup(param1:HabboFriendList)
      {
         super();
         this._friendList = param1;
      }
      
      public function show(param1:int, param2:int) : void
      {
         if(this._alert != null)
         {
            this.close(null);
         }
         this._alert = this.getOpenedToWebAlert();
         if(this.var_205 != null)
         {
            this.var_205.stop();
         }
         this.var_205 = new Timer(2000,1);
         this.var_205.addEventListener(TimerEvent.TIMER,this.close);
         this.var_205.start();
         this._alert.x = param1;
         this._alert.y = param2;
      }
      
      private function close(param1:Event) : void
      {
         this._alert.destroy();
         this._alert = null;
      }
      
      private function getOpenedToWebAlert() : IWindowContainer
      {
         var _loc1_:IWindowContainer = IWindowContainer(this._friendList.getXmlWindow("opened_to_web_popup"));
         this._friendList.refreshButton(_loc1_,"opened_to_web",true,null,0);
         return _loc1_;
      }
   }
}
