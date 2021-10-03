package com.sulake.habbo.help.help
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.enum.WindowParam;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.outgoing.help.GetFaqCategoryMessageComposer;
   import com.sulake.habbo.help.enum.HabboHelpViewEnum;
   import com.sulake.habbo.help.help.data.FaqCategory;
   import com.sulake.habbo.help.help.data.FaqIndex;
   import com.sulake.habbo.help.help.data.FaqItem;
   import com.sulake.habbo.window.IHabboWindowManager;
   
   public class FaqBrowseCategoryView extends HelpViewController
   {
       
      
      private var _category:FaqCategory;
      
      public function FaqBrowseCategoryView(param1:HelpUI, param2:IHabboWindowManager, param3:IAssetLibrary)
      {
         super(param1,param2,param3);
      }
      
      override public function render() : void
      {
         if(container != null)
         {
            container.dispose();
         }
         container = buildXmlWindow("help_faq_category") as IWindowContainer;
         if(container == null)
         {
            return;
         }
         var _loc1_:IWindow = container.findChildByTag("help_faq_back_link");
         if(_loc1_ != null)
         {
            _loc1_.setParamFlag(WindowParam.const_31);
            _loc1_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onBack);
         }
         super.render();
         if(this._category != null)
         {
            this.update();
         }
      }
      
      override public function update(param1:* = null) : void
      {
         var _loc6_:* = null;
         var _loc7_:* = null;
         super.update(param1);
         var _loc2_:FaqIndex = main.getFaq();
         if(param1 != null)
         {
            if(_loc2_ == null || container == null || param1 == null)
            {
               return;
            }
            this._category = FaqCategory(param1);
         }
         if(this._category == null)
         {
            return;
         }
         if(!this._category.hasContent())
         {
            main.sendMessage(new GetFaqCategoryMessageComposer(this._category.categoryId));
            return;
         }
         var _loc3_:IItemListWindow = container.findChildByTag("content") as IItemListWindow;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.destroyListItems();
         var _loc4_:Array = this._category.getQuestionTitleArray();
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc6_ = _loc4_[_loc5_];
            _loc7_ = buildHelpCategoryListEntryItem(_loc6_,"help_itemlist_item",this.onListItemClick);
            if(_loc7_ != null)
            {
               _loc3_.addListItem(_loc7_);
            }
            _loc5_++;
         }
      }
      
      private function onBack(param1:WindowMouseEvent) : void
      {
         main.showUI(HabboHelpViewEnum.const_574);
      }
      
      private function onListItemClick(param1:WindowMouseEvent) : void
      {
         var _loc2_:IWindow = param1.target as IWindow;
         this.handleListItemClick(_loc2_);
      }
      
      private function handleListItemClick(param1:IWindow) : void
      {
         var _loc2_:IItemListWindow = container.findChildByTag("content") as IItemListWindow;
         var _loc3_:FaqIndex = main.getFaq();
         if(_loc3_ == null || _loc2_ == null || param1 == null || param1.parent == null)
         {
            return;
         }
         var _loc4_:int = _loc2_.getListItemIndex(param1.parent);
         if(this._category == null)
         {
            return;
         }
         var _loc5_:FaqItem = this._category.getItemByIndex(_loc4_);
         if(_loc5_ != null)
         {
            main.showUI(HabboHelpViewEnum.const_274);
            main.tellUI(HabboHelpViewEnum.const_274,_loc5_);
         }
      }
   }
}
