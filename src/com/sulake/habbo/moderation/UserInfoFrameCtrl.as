package com.sulake.habbo.moderation
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.IFrameWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   
   public class UserInfoFrameCtrl implements IDisposable, TrackedWindow
   {
       
      
      private var var_33:ModerationManager;
      
      private var _userId:int;
      
      private var _frame:IFrameWindow;
      
      private var _disposed:Boolean;
      
      private var var_1207:UserInfoCtrl;
      
      public function UserInfoFrameCtrl(param1:ModerationManager, param2:int)
      {
         super();
         this.var_33 = param1;
         this._userId = param2;
      }
      
      public function get disposed() : Boolean
      {
         return this._disposed;
      }
      
      public function show() : void
      {
         this._frame = IFrameWindow(this.var_33.getXmlWindow("user_info_frame"));
         this._frame.caption = "User Info";
         var _loc1_:IWindow = this._frame.findChildByTag("close");
         _loc1_.procedure = this.onClose;
         this.var_1207 = new UserInfoCtrl(this._frame,this.var_33,"",true);
         this.var_1207.load(this._frame.content,this._userId);
         this._frame.visible = true;
      }
      
      public function getType() : int
      {
         return WindowTracker.const_1585;
      }
      
      public function getId() : String
      {
         return "" + this._userId;
      }
      
      public function getFrame() : IFrameWindow
      {
         return this._frame;
      }
      
      private function onClose(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         this.dispose();
      }
      
      public function dispose() : void
      {
         if(this._disposed)
         {
            return;
         }
         this._disposed = true;
         if(this._frame != null)
         {
            this._frame.destroy();
            this._frame = null;
         }
         if(this.var_1207 != null)
         {
            this.var_1207.dispose();
            this.var_1207 = null;
         }
         this.var_33 = null;
      }
   }
}
