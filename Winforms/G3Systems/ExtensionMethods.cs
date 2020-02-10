using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace G3Systems.Extensions
{
    public static class ExtensionMethods
    {
        /// <summary>
        /// Read string in value="" from appsettings in App.Config and convert to required type
        /// </summary>
        public static T GetConfigSetting<T>(this string key, T defaultValue = default) where T : IConvertible
        {
            string val = ConfigurationManager.AppSettings[key] ?? "";
            T result = defaultValue;
            if (!string.IsNullOrEmpty(val))
            {
                T typeDefault = default;
                result = (T)Convert.ChangeType(val, typeDefault.GetTypeCode());
            }
            return result;
        }
    }
}
