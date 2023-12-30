package seer2.next.entry
{
import com.taomee.seer2.app.config.ItemConfig;
import com.taomee.seer2.app.config.PetConfig;
import com.taomee.seer2.app.config.SkillConfig;
import com.taomee.seer2.app.config.SkillSideEffectConfig;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.UILoader;

public class ReloadConfig
{


    public function ReloadConfig()
    {
        super();
    }

    public static function loadConfig() : void
    {
        UILoader.load("config/binaryData/2_com.taomee.seer2.app.config.ItemConfig__itemXmlClass.xml",LoadType.TEXT,function(param1:ContentInfo):void
        {
            ItemConfig.parseItems(XML(param1.content));
        });
        UILoader.load("config/binaryData/15_com.taomee.seer2.app.config.SkillConfig__movesXmlClass.xml",LoadType.TEXT,function(param1:ContentInfo):void
        {
            SkillConfig.parseNormalSklls(XML(param1.content));
        });
        UILoader.load("config/binaryData/7_com.taomee.seer2.app.config.SkillSideEffectConfig__buffXmlClass.xml",LoadType.TEXT,function(param1:ContentInfo):void
        {
            SkillSideEffectConfig.parseBuffConfigXml(XML(param1.content));
        });
        UILoader.load("config/binaryData/64_com.taomee.seer2.app.config.PetConfig__petXmlClass.xml",LoadType.TEXT,function(param1:ContentInfo):void
        {
            UILoader.load("config/binaryData/45_com.taomee.seer2.app.config.PetConfig__dictionaryXmlClass.xml",LoadType.TEXT,function(param2:ContentInfo):void
            {
                UILoader.load("config/binaryData/19_com.taomee.seer2.app.config.PetConfig__dialogXmlClass.xml",LoadType.TEXT,function(param3:ContentInfo):void
                {
                    PetConfig.parseData(XML(param1.content),XML(param2.content),XML(param3.content));
                });
            });
        });
    }
}
}
