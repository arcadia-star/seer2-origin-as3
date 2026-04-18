package seer2.next.fight.ui {
import com.taomee.seer2.app.arena.data.AnimiationHitInfo;
import com.taomee.seer2.app.arena.util.FighterActionType;
import com.taomee.seer2.app.arena.util.HitInfoConfig;
import com.taomee.seer2.app.arena.util.SkillCategoryName;
import com.taomee.seer2.app.config.PetSkinConfig;

public class FightUIUtil {
    public function FightUIUtil() {
    }

    public static function skinnedMonster(side:int, monster:int):int {
        //皮肤系统
        if (side === 1) {
            var skinId:uint = PetSkinConfig.getSkinId(monster);
            if (skinId > 0) {
                return skinId;
            }
        }
        return monster;
    }

    public static function hitTimeout(side:int, monster:int, category:String):int {
        var hitInfo:AnimiationHitInfo = HitInfoConfig.getHitData(FightUIUtil.skinnedMonster(side, monster));
        return hitInfo.getHitValue(playLabel(category));
    }

    public static function playLabel(category:String):String {
        switch (category) {
            case SkillCategoryName.PHY:
                return FighterActionType.ATK_PHY;
            case SkillCategoryName.POW:
                return FighterActionType.ATK_POW;
            case SkillCategoryName.POW_INTERCOURSE_VALUE:
                return FighterActionType.INTERCOURSE;
            case SkillCategoryName.BUF:
                return FighterActionType.ATK_BUF;
            case SkillCategoryName.SPE:
                return FighterActionType.ATK_SPE;
        }
        return FighterActionType.ATK_PHY;
    }
}
}
