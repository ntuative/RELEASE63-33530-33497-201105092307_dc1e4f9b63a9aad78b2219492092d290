package com.sulake.habbo.messenger
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IFrameWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.messenger.domain.Conversation;
   
   public class ConversationsTabView
   {
       
      
      private var var_138:HabboMessenger;
      
      private var var_175:IWindowContainer;
      
      private var var_965:IWindowContainer;
      
      private var var_1187:int = 30;
      
      public function ConversationsTabView(param1:HabboMessenger, param2:IFrameWindow)
      {
         super();
         this.var_138 = param1;
         this.var_175 = IWindowContainer(param2.findChildByName("content"));
         this.var_965 = IWindowContainer(param2.findChildByName("conversationstab"));
         var _loc3_:IBitmapWrapperWindow = IBitmapWrapperWindow(this.var_175.findChildByName("convo_bg"));
         _loc3_.bitmap = this.var_138.getButtonImage("convo_bg");
      }
      
      public function getTabCount() : int
      {
         return Math.floor(this.var_965.width / this.var_1187);
      }
      
      public function get content() : IWindowContainer
      {
         return this.var_175;
      }
      
      public function refresh() : void
      {
         var _loc3_:Boolean = false;
         var _loc1_:Array = this.var_138.conversations.openConversations;
         var _loc2_:int = 0;
         while(_loc2_ < this.getTabCount())
         {
            this.refreshTabContent(_loc2_,_loc1_[this.var_138.conversations.startIndex + _loc2_]);
            _loc2_++;
         }
         while(true)
         {
            _loc3_ = this.refreshTabContent(_loc2_,null);
            if(_loc3_)
            {
               break;
            }
            _loc2_++;
         }
         if(this.hasPrevButton())
         {
            this.refreshAsArrow(0,false);
         }
         if(this.hasNextButton())
         {
            this.refreshAsArrow(this.getTabCount() - 1,true);
         }
      }
      
      private function refreshTabContent(param1:int, param2:Conversation) : Boolean
      {
         var _loc3_:IWindowContainer = this.var_965.getChildAt(param1) as IWindowContainer;
         if(_loc3_ == null)
         {
            if(param2 == null)
            {
               return true;
            }
            _loc3_ = IWindowContainer(this.var_138.getXmlWindow("tab_entry"));
            _loc3_.y = 1;
            this.var_965.addChild(_loc3_);
         }
         this.hideChildren(_loc3_);
         if(param2 == null)
         {
            return false;
         }
         var _loc4_:String = !!param2.selected ? "tab_bg_sel" : (!!param2.newMessageArrived ? "tab_bg_hilite" : "tab_bg_unsel");
         this.refreshTabBg(_loc3_,param1,_loc4_);
         this.refreshFigure(_loc3_,param2.figure);
         _loc3_.x = param1 * this.var_1187;
         _loc3_.width = this.var_1187;
         return false;
      }
      
      private function hideChildren(param1:IWindowContainer) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1.numChildren)
         {
            param1.getChildAt(_loc2_).visible = false;
            _loc2_++;
         }
      }
      
      private function refreshAsArrow(param1:int, param2:Boolean) : void
      {
         var _loc3_:IWindowContainer = this.var_965.getChildAt(param1) as IWindowContainer;
         this.hideChildren(_loc3_);
         this.refreshArrow(_loc3_,param1,param2);
         this.refreshTabBg(_loc3_,param1,!!param2 ? "tab_bg_next" : "tab_bg_unsel");
         var _loc4_:int = this.var_965.width % this.var_1187;
         _loc3_.width = this.var_1187 + (!!param2 ? _loc4_ : 0);
      }
      
      private function refreshTabBg(param1:IWindowContainer, param2:int, param3:String) : void
      {
         this.var_138.refreshButton(param1,param3,true,this.onTabClick,param2);
      }
      
      private function refreshFigure(param1:IWindowContainer, param2:String) : void
      {
         var _loc3_:IBitmapWrapperWindow = param1.getChildByName(HabboMessenger.const_174) as IBitmapWrapperWindow;
         if(param2 == null || param2 == "")
         {
            _loc3_.visible = false;
         }
         else
         {
            _loc3_.bitmap = this.var_138.getAvatarFaceBitmap(param2);
            _loc3_.visible = true;
         }
      }
      
      private function refreshArrow(param1:IWindowContainer, param2:int, param3:Boolean) : void
      {
         this.var_138.refreshButton(param1,!!param3 ? "next" : "prev",true,null,0);
      }
      
      private function hasPrevButton() : Boolean
      {
         return this.var_138.conversations.startIndex > 0;
      }
      
      private function hasNextButton() : Boolean
      {
         return this.var_138.conversations.openConversations.length - this.var_138.conversations.startIndex > this.getTabCount();
      }
      
      private function onTabClick(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc4_:* = null;
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         var _loc3_:int = param2.id;
         if(_loc3_ == 0 && this.hasPrevButton())
         {
            this.var_138.conversations.changeStartIndex(-1);
         }
         else if(_loc3_ == this.getTabCount() - 1 && this.hasNextButton())
         {
            this.var_138.conversations.changeStartIndex(1);
         }
         else
         {
            _loc4_ = param2.name == HabboMessenger.const_174 ? this.var_138.conversations.findConversation(param2.id) : this.var_138.conversations.openConversations[_loc3_ + this.var_138.conversations.startIndex];
            if(_loc4_ == null)
            {
               return;
            }
            this.var_138.conversations.setSelected(_loc4_);
         }
         this.var_138.messengerView.refresh();
      }
   }
}
