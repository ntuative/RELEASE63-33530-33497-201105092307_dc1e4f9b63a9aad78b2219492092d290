package com.sulake.habbo.help.cfh
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.help.enum.HabboHelpViewEnum;
   import com.sulake.habbo.help.help.HelpUI;
   import com.sulake.habbo.help.help.HelpViewController;
   import com.sulake.habbo.help.help.IHelpViewController;
   import com.sulake.habbo.window.IHabboWindowManager;
   
   public class CallForHelpTopicSelection extends HelpViewController implements IHelpViewController
   {
      
      private static const const_1413:int = 0;
      
      private static const const_456:int = 1;
       
      
      private var var_750:Array;
      
      public function CallForHelpTopicSelection(param1:HelpUI, param2:IHabboWindowManager, param3:IAssetLibrary)
      {
         super(param1,param2,param3);
      }
      
      override public function render() : void
      {
         var _loc3_:* = null;
         var _loc5_:* = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         super.render();
         if(container != null)
         {
            container.dispose();
         }
         var _loc1_:int = const_1413;
         if(main.component.callForHelpData.userSelected)
         {
            _loc1_ = const_456;
         }
         if(_loc1_ == const_456)
         {
            container = buildXmlWindow("report_user_pick_topic") as IWindowContainer;
         }
         else
         {
            container = buildXmlWindow("help_cfh_pick_topic") as IWindowContainer;
         }
         if(container == null)
         {
            return;
         }
         var _loc2_:IItemListWindow = container.findChildByTag("content") as IItemListWindow;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc1_ == const_456)
         {
            _loc3_ = main.getConfigurationKey("cfh.usercategories.withharasser");
         }
         else
         {
            _loc3_ = main.getConfigurationKey("cfh.usercategories.withnoharasser");
         }
         var _loc4_:Array = _loc3_.split(",");
         this.var_750 = new Array();
         for each(_loc5_ in _loc4_)
         {
            _loc7_ = int(_loc5_.replace(" ",""));
            if(_loc7_ != 0)
            {
               this.var_750.push(_loc7_);
            }
         }
         _loc6_ = 0;
         while(_loc6_ < this.var_750.length)
         {
            _loc8_ = this.var_750[_loc6_];
            _loc9_ = main.component.callForHelpData.getTopicKey(_loc8_);
            if(_loc1_ == const_456)
            {
               main.localization.registerParameter(_loc9_,"name",main.component.callForHelpData.reportedUserName);
            }
            _loc10_ = getText(main.component.callForHelpData.getTopicKey(_loc8_));
            _loc11_ = buildHelpCategoryListEntryItem(_loc10_ != null ? _loc10_ : _loc9_,"help_cfh_pick_topic_item",this.onListItemClick);
            if(_loc11_ != null)
            {
               _loc2_.addListItem(_loc11_);
            }
            _loc6_++;
         }
      }
      
      private function onListItemClick(param1:WindowMouseEvent) : void
      {
         var _loc2_:IWindow = param1.target as IWindow;
         this.handleListItemClick(_loc2_);
      }
      
      private function handleListItemClick(param1:IWindow) : void
      {
         var _loc2_:IItemListWindow = container.findChildByTag("content") as IItemListWindow;
         if(_loc2_ == null || param1 == null || param1.parent == null)
         {
            return;
         }
         var _loc3_:int = _loc2_.getListItemIndex(param1.parent);
         if(this.var_750 == null || _loc3_ < 0 || _loc3_ >= this.var_750.length)
         {
            return;
         }
         if(_loc3_ > -1)
         {
            main.component.callForHelpData.topicIndex = this.var_750[_loc3_];
            main.showUI(HabboHelpViewEnum.const_974);
            main.tellUI(HabboHelpViewEnum.const_974,null);
         }
      }
   }
}
