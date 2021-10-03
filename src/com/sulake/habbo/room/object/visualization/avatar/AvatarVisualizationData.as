package com.sulake.habbo.room.object.visualization.avatar
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.habbo.avatar.IAvatarImage;
   import com.sulake.habbo.avatar.IAvatarImageListener;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.avatar.enum.AvatarScaleType;
   import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
   
   public class AvatarVisualizationData implements IRoomObjectVisualizationData
   {
       
      
      private var _avatarRenderer:IAvatarRenderManager = null;
      
      public function AvatarVisualizationData()
      {
         super();
      }
      
      public function get avatarRenderer() : IAvatarRenderManager
      {
         return this._avatarRenderer;
      }
      
      public function set avatarRenderer(param1:IAvatarRenderManager) : void
      {
         this._avatarRenderer = param1;
      }
      
      public function initialize(param1:XML) : Boolean
      {
         return true;
      }
      
      public function dispose() : void
      {
         this._avatarRenderer = null;
      }
      
      public function getAvatar(param1:String, param2:Number, param3:String = null, param4:IAvatarImageListener = null) : IAvatarImage
      {
         var _loc5_:* = null;
         if(this._avatarRenderer != null)
         {
            _loc5_ = null;
            if(param2 > 48)
            {
               _loc5_ = this._avatarRenderer.createAvatarImage(param1,AvatarScaleType.const_56,param3,param4);
            }
            else
            {
               _loc5_ = this._avatarRenderer.createAvatarImage(param1,AvatarScaleType.const_91,param3,param4);
            }
            return _loc5_;
         }
         return null;
      }
      
      public function getLayerCount(param1:String) : Number
      {
         return 0;
      }
      
      public function getAvatarRendererAsset(param1:String) : IAsset
      {
         if(this._avatarRenderer == null)
         {
            return null;
         }
         return this._avatarRenderer.assets.getAssetByName(param1);
      }
   }
}
