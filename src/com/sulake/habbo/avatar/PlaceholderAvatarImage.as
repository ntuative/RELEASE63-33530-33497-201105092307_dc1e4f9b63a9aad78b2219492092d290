package com.sulake.habbo.avatar
{
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.avatar.alias.AssetAliasCollection;
   import com.sulake.habbo.avatar.cache.AvatarImageCache;
   import com.sulake.habbo.avatar.enum.AvatarAction;
   import flash.display.BitmapData;
   
   public class PlaceholderAvatarImage extends AvatarImage
   {
      
      static var var_804:Map = new Map();
       
      
      public function PlaceholderAvatarImage(param1:AvatarStructure, param2:AssetAliasCollection, param3:AvatarFigureContainer, param4:String)
      {
         super(param1,param2,param3,param4);
      }
      
      override public function dispose() : void
      {
         var _loc1_:* = null;
         if(!var_1076)
         {
            _structure = null;
            _assets = null;
            var_277 = null;
            var_286 = null;
            var_692 = null;
            var_571 = null;
            var_334 = null;
            if(!var_1334 && var_46)
            {
               var_46.dispose();
            }
            var_46 = null;
            _loc1_ = getCache();
            if(_loc1_)
            {
               _loc1_.dispose();
               _loc1_ = null;
            }
            var_723 = null;
            var_1076 = true;
         }
      }
      
      override protected function getFullImage(param1:String) : BitmapData
      {
         return var_804[param1];
      }
      
      override protected function cacheFullImage(param1:String, param2:BitmapData) : void
      {
         var_804[param1] = param2;
      }
      
      override public function appendAction(param1:String, ... rest) : Boolean
      {
         var _loc3_:* = null;
         if(rest != null && rest.length > 0)
         {
            _loc3_ = rest[0];
         }
         switch(param1)
         {
            case AvatarAction.const_446:
               switch(_loc3_)
               {
                  case AvatarAction.const_895:
                  case AvatarAction.const_586:
                  case AvatarAction.const_379:
                  case AvatarAction.const_927:
                  case AvatarAction.const_391:
                  case AvatarAction.const_789:
                     super.appendAction.apply(null,[param1].concat(rest));
               }
               break;
            case AvatarAction.const_365:
            case AvatarAction.const_785:
            case AvatarAction.const_257:
            case AvatarAction.const_930:
            case AvatarAction.const_780:
            case AvatarAction.const_838:
               super.addActionData.apply(null,[param1].concat(rest));
         }
         return true;
      }
      
      override public function isPlaceholder() : Boolean
      {
         return true;
      }
   }
}
