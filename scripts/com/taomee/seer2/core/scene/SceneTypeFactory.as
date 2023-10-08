package com.taomee.seer2.core.scene
{
   import org.taomee.utils.DomainUtil;
   
   public class SceneTypeFactory
   {
       
      
      public function SceneTypeFactory()
      {
         super();
      }
      
      public static function createScene(param1:int) : BaseScene
      {
         var _loc2_:Class = null;
         switch(param1)
         {
            case SceneType.COPY:
            case SceneType.LOBBY:
               _loc2_ = DomainUtil.getCurrentDomainClass("com.taomee.seer2.app.lobby.LobbyScene");
               break;
            case SceneType.HOME:
               _loc2_ = DomainUtil.getCurrentDomainClass("com.taomee.seer2.app.home.HomeScene");
               break;
            case SceneType.ARENA:
               _loc2_ = DomainUtil.getCurrentDomainClass("com.taomee.seer2.app.arena.ArenaScene");
               break;
            case SceneType.TEAM:
               _loc2_ = DomainUtil.getCurrentDomainClass("com.taomee.seer2.app.team.TeamScene");
               break;
            case SceneType.NOVICE:
               _loc2_ = DomainUtil.getCurrentDomainClass("com.taomee.seer2.app.novice.NoviceScene");
               break;
            case SceneType.GUDIE_ARENA:
               _loc2_ = DomainUtil.getCurrentDomainClass("com.taomee.seer2.app.firstTeach.guide.GudieArenaScene");
               break;
            case SceneType.GUDIE_ARENA2:
            case SceneType.GUDIE_ARENA3:
            case SceneType.GUDIE_ARENA4:
            case SceneType.GUDIE_ARENA5:
            case SceneType.GUIDE_NEW_ARENA1:
            case SceneType.GUIDE_NEW_ARENA2:
            case SceneType.GUIDE_NEW_ARENA3:
               _loc2_ = DomainUtil.getCurrentDomainClass("com.taomee.seer2.app.firstTeach.guide.GudieArenaScene2");
               break;
            case SceneType.BIG_LOBBY:
               _loc2_ = DomainUtil.getCurrentDomainClass("com.taomee.seer2.app.lobby.BigLobbyScene");
               break;
            case SceneType.PLANT:
               _loc2_ = DomainUtil.getCurrentDomainClass("com.taomee.seer2.app.plant.PlantScene");
               break;
            default:
               _loc2_ = BaseScene;
         }
         return new _loc2_(param1);
      }
      
      public static function createMapLoader(param1:int) : BaseMapLoader
      {
         var _loc2_:Class = null;
         switch(param1)
         {
            case SceneType.BIG_LOBBY:
               _loc2_ = DomainUtil.getCurrentDomainClass("com.taomee.seer2.core.scene.BigMapLoader");
               break;
            default:
               _loc2_ = DomainUtil.getCurrentDomainClass("com.taomee.seer2.core.scene.MapLoader");
         }
         return new _loc2_();
      }
      
      public static function createMessageGateWay(param1:BaseScene) : MessageGateWay
      {
         var _loc2_:Class = null;
         switch(param1.type)
         {
            case SceneType.COPY:
               _loc2_ = DomainUtil.getCurrentDomainClass("com.taomee.seer2.app.copy.CopyMessageGateWay");
               break;
            case SceneType.LOBBY:
            case SceneType.TEAM:
            case SceneType.BIG_LOBBY:
               _loc2_ = DomainUtil.getCurrentDomainClass("com.taomee.seer2.app.lobby.LobbyMessageGateWay");
               break;
            case SceneType.HOME:
               _loc2_ = DomainUtil.getCurrentDomainClass("com.taomee.seer2.app.home.HomeMessageGateWay");
               break;
            case SceneType.ARENA:
               _loc2_ = DomainUtil.getCurrentDomainClass("com.taomee.seer2.app.arena.ArenaMessageGateWay");
               break;
            case SceneType.NOVICE:
               _loc2_ = DomainUtil.getCurrentDomainClass("com.taomee.seer2.app.novice.NoviceMessageGateWay");
               break;
            case SceneType.PLANT:
               _loc2_ = DomainUtil.getCurrentDomainClass("com.taomee.seer2.app.home.HomeMessageGateWay");
               break;
            default:
               _loc2_ = MessageGateWay;
         }
         return new _loc2_(param1);
      }
      
      public static function createSceneHandlerGateWay(param1:BaseScene) : SceneHandlerGateWay
      {
         var _loc2_:Class = null;
         switch(param1.type)
         {
            case SceneType.HOME:
               _loc2_ = DomainUtil.getCurrentDomainClass("com.taomee.seer2.app.home.HomeSceneHandlerGateWay");
               break;
            case SceneType.LOBBY:
               _loc2_ = DomainUtil.getCurrentDomainClass("com.taomee.seer2.app.lobby.LobbySceneHandlerGateWay");
               break;
            default:
               _loc2_ = SceneHandlerGateWay;
         }
         return new _loc2_(param1);
      }
      
      public static function createSwitchPreProcessor(param1:int) : SwitchPreProcessor
      {
         var _loc2_:Class = null;
         switch(param1)
         {
            case SceneType.COPY:
            case SceneType.LOBBY:
               _loc2_ = DomainUtil.getCurrentDomainClass("com.taomee.seer2.app.scene.preProcessor.LobbyPreProcessor");
               break;
            case SceneType.HOME:
               _loc2_ = DomainUtil.getCurrentDomainClass("com.taomee.seer2.app.scene.preProcessor.HomePreProcessor");
               break;
            case SceneType.ARENA:
               _loc2_ = DomainUtil.getCurrentDomainClass("com.taomee.seer2.app.scene.preProcessor.ArenaPreProcessor");
               break;
            case SceneType.TEAM:
               _loc2_ = DomainUtil.getCurrentDomainClass("com.taomee.seer2.app.scene.preProcessor.TeamPreProcessor");
               break;
            case SceneType.GUDIE_ARENA:
               _loc2_ = DomainUtil.getCurrentDomainClass("com.taomee.seer2.app.scene.preProcessor.GudieArenaPreProcessor");
               break;
            case SceneType.GUDIE_ARENA2:
            case SceneType.GUDIE_ARENA3:
            case SceneType.GUDIE_ARENA4:
            case SceneType.GUDIE_ARENA5:
            case SceneType.GUIDE_NEW_ARENA1:
            case SceneType.GUIDE_NEW_ARENA2:
            case SceneType.GUIDE_NEW_ARENA3:
               _loc2_ = DomainUtil.getCurrentDomainClass("com.taomee.seer2.app.scene.preProcessor.GudieNewArenaPreProcessor");
               break;
            case SceneType.BIG_LOBBY:
               _loc2_ = DomainUtil.getCurrentDomainClass("com.taomee.seer2.app.scene.preProcessor.LobbyPreProcessor");
               break;
            case SceneType.PLANT:
               _loc2_ = DomainUtil.getCurrentDomainClass("com.taomee.seer2.app.scene.preProcessor.PlantPreProcessor");
               break;
            default:
               _loc2_ = SwitchPreProcessor;
         }
         return new _loc2_();
      }
   }
}
