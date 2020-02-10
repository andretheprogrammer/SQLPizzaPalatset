using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using System.Data;
using TypeLib;
using Dapper;
using Npgsql;

namespace PostgreSQL
{
    public class G3SystemsRepository //: IG3SystemsRepository
    {
        private readonly string _connString;

        public G3SystemsRepository()
        {
            // Gets connectionstring from App.config in G3Systems
            _connString = ConfigurationManager.ConnectionStrings["npgsql"].ConnectionString;
        }

        /// <summary>
        /// Open new connection and return it for use
        /// </summary>
        /// <returns></returns>
        private IDbConnection CreateConnection()
        {
            var conn = new NpgsqlConnection(_connString);
            conn.Open();
            return conn;
        }
    }
}
