package com.sulake.core.window
{
   import com.sulake.core.window.components.ActivatorController;
   import com.sulake.core.window.components.BackgroundController;
   import com.sulake.core.window.components.BitmapWrapperController;
   import com.sulake.core.window.components.BorderController;
   import com.sulake.core.window.components.ButtonController;
   import com.sulake.core.window.components.CanvasController;
   import com.sulake.core.window.components.CheckBoxController;
   import com.sulake.core.window.components.CloseButtonController;
   import com.sulake.core.window.components.ContainerButtonController;
   import com.sulake.core.window.components.ContainerController;
   import com.sulake.core.window.components.DisplayObjectWrapperController;
   import com.sulake.core.window.components.DropMenuController;
   import com.sulake.core.window.components.DropMenuItemController;
   import com.sulake.core.window.components.FrameController;
   import com.sulake.core.window.components.HTMLTextController;
   import com.sulake.core.window.components.HeaderController;
   import com.sulake.core.window.components.IconController;
   import com.sulake.core.window.components.ItemGridController;
   import com.sulake.core.window.components.ItemListController;
   import com.sulake.core.window.components.PasswordFieldController;
   import com.sulake.core.window.components.RadioButtonController;
   import com.sulake.core.window.components.RegionController;
   import com.sulake.core.window.components.ScalerController;
   import com.sulake.core.window.components.ScrollableItemListWindow;
   import com.sulake.core.window.components.ScrollbarController;
   import com.sulake.core.window.components.ScrollbarLiftController;
   import com.sulake.core.window.components.SelectableButtonController;
   import com.sulake.core.window.components.SelectorController;
   import com.sulake.core.window.components.TabButtonController;
   import com.sulake.core.window.components.TabContainerButtonController;
   import com.sulake.core.window.components.TabContextController;
   import com.sulake.core.window.components.TabSelectorController;
   import com.sulake.core.window.components.TextController;
   import com.sulake.core.window.components.TextFieldController;
   import com.sulake.core.window.components.TextLabelController;
   import com.sulake.core.window.components.ToolTipController;
   import com.sulake.core.window.enum.WindowType;
   import flash.utils.Dictionary;
   
   public class Classes
   {
      
      protected static var var_14:Dictionary;
       
      
      public function Classes()
      {
         super();
      }
      
      public static function init() : void
      {
         if(!var_14)
         {
            var_14 = new Dictionary();
            var_14["null"] = WindowController;
            var_14["null"] = ActivatorController;
            var_14["null"] = BackgroundController;
            var_14["null"] = BorderController;
            var_14["null"] = ButtonController;
            var_14["null"] = ButtonController;
            var_14["null"] = SelectableButtonController;
            var_14["null"] = SelectableButtonController;
            var_14["null"] = SelectableButtonController;
            var_14["null"] = BitmapWrapperController;
            var_14["null"] = CanvasController;
            var_14["null"] = CheckBoxController;
            var_14["null"] = ContainerController;
            var_14["null"] = ContainerButtonController;
            var_14["null"] = CloseButtonController;
            var_14["null"] = DisplayObjectWrapperController;
            var_14["null"] = ScrollbarLiftController;
            var_14["null"] = DropMenuController;
            var_14["null"] = DropMenuItemController;
            var_14["null"] = FrameController;
            var_14["null"] = HeaderController;
            var_14["null"] = HTMLTextController;
            var_14["null"] = IconController;
            var_14["null"] = ItemListController;
            var_14["null"] = ItemListController;
            var_14["null"] = ItemListController;
            var_14["null"] = ItemGridController;
            var_14["null"] = ItemGridController;
            var_14["null"] = ItemGridController;
            var_14["null"] = TextLabelController;
            var_14["null"] = PasswordFieldController;
            var_14["null"] = RadioButtonController;
            var_14["null"] = RegionController;
            var_14["null"] = ScalerController;
            var_14["null"] = ScrollbarController;
            var_14["null"] = ScrollbarController;
            var_14["null"] = ButtonController;
            var_14["null"] = ButtonController;
            var_14["null"] = ButtonController;
            var_14["null"] = ButtonController;
            var_14["null"] = ScrollbarLiftController;
            var_14["null"] = ScrollbarLiftController;
            var_14["null"] = WindowController;
            var_14["null"] = WindowController;
            var_14["null"] = ScrollableItemListWindow;
            var_14["null"] = SelectorController;
            var_14["null"] = TabSelectorController;
            var_14["null"] = TabButtonController;
            var_14["null"] = TabContainerButtonController;
            var_14["null"] = ContainerController;
            var_14["null"] = TabContextController;
            var_14["null"] = TabSelectorController;
            var_14["null"] = TextController;
            var_14["null"] = TextFieldController;
            var_14["null"] = ToolTipController;
         }
      }
      
      public static function getWindowClassByType(param1:uint) : Class
      {
         return var_14[param1];
      }
   }
}
