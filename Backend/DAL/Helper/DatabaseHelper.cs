﻿using DAL.Helper.Interfaces;
using Microsoft.Extensions.Configuration;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Text;

namespace DAL.Helper
{
    public class DatabaseHelper : IDatabaseHelper
    {
        //Connection String
        public string StrConnection { get; set; }
        //Connection
        public MySqlConnection MySqlConnection { get; set; }
        //NpgMySqlTransaction 
        public MySqlTransaction MySqlTransaction { get; set; }
        public DatabaseHelper(IConfiguration configuration)
        {
            StrConnection = configuration["ConnectionStrings:DefaultConnection"];
        }
        /// <summary>
        /// Set Connection String
        /// </summary>
        /// <param name="connectionString"></param>
        public void SetConnectionString(string connectionString)
        {
            StrConnection = connectionString;
        }
        /// <summary>
        /// Open Connect to PostGres DB
        /// </summary>
        /// <returns>String.Empty when connected or Message Error when connect happen issue</returns>
        public string OpenConnection()
        {
            try
            {
                if (MySqlConnection == null)
                    MySqlConnection = new MySqlConnection(StrConnection);

                if (MySqlConnection.State != ConnectionState.Open)
                    MySqlConnection.Open();

                return "";
            }
            catch (Exception exception)
            {
                return exception.Message;
            }
        }
        /// <summary>
        /// Open Connect begin transaction to PostGres DB
        /// </summary>
        /// <returns>String.Empty when connected or Message Error when connect happen issue</returns>
        public string OpenConnectionAndBeginTransaction()
        {
            try
            {
                if (MySqlConnection == null)
                    MySqlConnection = new MySqlConnection(StrConnection);

                if (MySqlConnection.State != ConnectionState.Open)
                    MySqlConnection.Open();

                MySqlTransaction = MySqlConnection.BeginTransaction();

                return "";
            }
            catch (Exception exception)
            {
                if (MySqlConnection != null)
                    MySqlConnection.Dispose();

                if (MySqlTransaction != null)
                    MySqlTransaction.Dispose();

                return exception.Message;
            }
        }
        /// <summary>
        /// Close Connect and end transaction to PostGres DB
        /// </summary>
        /// <returns>String.Empty when Close connect success or Message Error when connection close happen issue</returns>
        public string CloseConnectionAndEndTransaction(bool isRollbackTransaction)
        {
            try
            {
                if (MySqlTransaction != null)
                {
                    if (isRollbackTransaction)
                        MySqlTransaction.Rollback();
                    else MySqlTransaction.Commit();
                }

                if (MySqlConnection != null && MySqlConnection.State != ConnectionState.Closed)
                    MySqlConnection.Close();
                return "";
            }
            catch (Exception exception)
            {
                return exception.Message;
            }
        }
        /// <summary>
        /// Close Connect to PostGres DB
        /// </summary>
        /// <returns>String.Empty when Close connect success or Message Error when connection close happen issue</returns>
        public string CloseConnection()
        {
            try
            {
                if (MySqlConnection != null && MySqlConnection.State != ConnectionState.Closed)
                    MySqlConnection.Close();
                return "";
            }
            catch (Exception exception)
            {
                return exception.Message;
            }
        }

        public string ExecuteNoneQuery(string strquery)
        {
            string msgError = "";
            try
            {
                OpenConnection();
                var MySqlCommand = new MySqlCommand(strquery, MySqlConnection);
                MySqlCommand.ExecuteNonQuery();
                MySqlCommand.Dispose();
            }
            catch (Exception exception)
            {
                msgError = exception.ToString();
            }
            finally
            {
                CloseConnection();
            }
            return msgError;
        }

        public DataTable ExecuteQueryToDataTable(string strquery, out string msgError)
        {
            msgError = "";
            var result = new DataTable();
            var MySqlDataAdapter = new MySqlDataAdapter(strquery, StrConnection);
            try
            {
                MySqlDataAdapter.Fill(result);
            }
            catch (Exception exception)
            {
                msgError = exception.ToString();
                result = null;
            }
            finally
            {
                MySqlDataAdapter.Dispose();
            }
            return result;
        }

        public object ExecuteScalar(string strquery, out string msgError)
        {
            object result = null;
            try
            {
                OpenConnection();
                var npgMySqlCommand = new MySqlCommand(strquery, MySqlConnection);
                result = npgMySqlCommand.ExecuteScalar();
                npgMySqlCommand.Dispose();
                msgError = "";
            }
            catch (Exception ex) { msgError = ex.StackTrace; }
            finally
            {
                CloseConnection();
            }
            return result;
        }
        #region Execute StoreProcedure
        /// <summary>
        /// Execute Procedure None Query
        /// </summary>
        /// <param name="sprocedureName">Procedure Name</param>
        /// <param name="paramObjects">List Param Objects, Each Item include 'ParamName' and 'ParamValue'</param>
        /// <returns>String.Empty when run query success or Message Error when run query happen issue</returns>
        public string ExecuteSProcedure(string sprocedureName, params object[] paramObjects)
        {
            string result = "";
            MySqlConnection connection = new MySqlConnection(StrConnection);
            try
            {
                MySqlCommand cmd = new MySqlCommand { CommandType = CommandType.StoredProcedure, CommandText = sprocedureName };
                connection.Open();
                cmd.Connection = connection;
                int parameterInput = (paramObjects.Length) / 2;
                int j = 0;
                for (int i = 0; i < parameterInput; i++)
                {
                    string paramName = Convert.ToString(paramObjects[j++]);
                    object value = paramObjects[j++];
                    if (paramName.ToLower().Contains("json"))
                    {
                        cmd.Parameters.Add(new MySqlParameter()
                        {
                            ParameterName = paramName,
                            Value = value ?? DBNull.Value,
                            MySqlDbType = MySqlDbType.Text
                        });
                    }
                    else
                    {
                        cmd.Parameters.Add(new MySqlParameter(paramName, value ?? DBNull.Value));
                    }
                }
                cmd.ExecuteNonQuery();
                cmd.Dispose();
            }
            catch (Exception exception)
            {
                result = exception.ToString();
            }
            finally
            {
                connection.Close();
            }
            return result;
        }

        /// <summary>
        /// Execute Procedure None Query with transaction
        /// </summary>
        /// <param name="sprocedureName">Procedure Name</param>
        /// <param name="paramObjects">List Param Objects, Each Item include 'ParamName' and 'ParamValue'</param>
        /// <returns>String.Empty when run query success or Message Error when run query happen issue</returns>
        public string ExecuteSProcedureWithTransaction(string sprocedureName, params object[] paramObjects)
        {
            string result = "";
            using (MySqlConnection connection = new MySqlConnection(StrConnection))
            {
                connection.Open();
                using (MySqlTransaction transaction = connection.BeginTransaction())
                {
                    try
                    {
                        MySqlCommand cmd = connection.CreateCommand();
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandText = sprocedureName;
                        cmd.Transaction = transaction;
                        cmd.Connection = connection;
                        int parameterInput = (paramObjects.Length) / 2;
                        int j = 0;
                        for (int i = 0; i < parameterInput; i++)
                        {
                            string paramName = Convert.ToString(paramObjects[j++]);
                            object value = paramObjects[j++];
                            //DbType type = ConvertSystemType2DbType(value);
                            if (paramName.ToLower().Contains("json"))
                            {
                                cmd.Parameters.Add(new MySqlParameter()
                                {
                                    ParameterName = paramName,
                                    Value = value ?? DBNull.Value,
                                    MySqlDbType = MySqlDbType.Text
                                });
                            }
                            else
                            {
                                cmd.Parameters.Add(new MySqlParameter(paramName, value ?? DBNull.Value));
                            }
                        }
                        cmd.ExecuteNonQuery();
                        cmd.Dispose();
                        transaction.Commit();
                    }
                    catch (Exception exception)
                    {
                        result = exception.ToString();
                        try
                        {
                            transaction.Rollback();
                        }
                        catch (Exception ex) { }
                    }
                    finally
                    {
                        connection.Close();
                    }
                }
            }
            return result;
        }
        /// <summary>
        /// Execute Scalar Procedure query List store and command
        /// </summary>
        /// <param name="storeParameterInfos">List Store and ListList Parameter</param>
        /// <returns>List msgErrors return from storeprocedure</returns>
        public List<string> ExecuteScalarSProcedure(List<StoreParameterInfo> storeParameterInfos)
        {
            var msgErrors = new List<string>();
            List<object> result = new List<object>();
            using (MySqlConnection connection = new MySqlConnection(StrConnection))
            {
                connection.Open();

                using (MySqlCommand cmd = new MySqlCommand { CommandType = CommandType.StoredProcedure, Connection = connection })
                {

                    for (int p = 0; p < storeParameterInfos.Count; p++)
                    {
                        try
                        {
                            cmd.CommandText = storeParameterInfos[p].StoreProcedureName;
                            int parameterInput = storeParameterInfos[p].StoreProcedureParams == null ? 0 : (storeParameterInfos[p].StoreProcedureParams.Count) / 2;
                            int j = 0;

                            if (cmd.Parameters != null && cmd.Parameters.Count > 0)
                                cmd.Parameters.Clear();

                            for (int i = 0; i < parameterInput; i++)
                            {
                                string paramName = Convert.ToString(storeParameterInfos[p].StoreProcedureParams[j++]);
                                object value = storeParameterInfos[p].StoreProcedureParams[j++];
                                if (paramName.ToLower().Contains("json"))
                                {
                                    cmd.Parameters.Add(new MySqlParameter()
                                    {
                                        ParameterName = paramName,
                                        Value = value ?? DBNull.Value,
                                        MySqlDbType = MySqlDbType.Text
                                    });
                                }
                                else
                                {
                                    cmd.Parameters.Add(new MySqlParameter(paramName, value ?? DBNull.Value));
                                }
                            }

                            cmd.ExecuteNonQuery();
                        }
                        catch (Exception exception)
                        {
                            msgErrors.Add(exception.StackTrace);
                        }
                    }
                }
            }
            return msgErrors;
        }
        /// <summary>
        /// Execute Procedure query List store with transaction
        /// </summary>
        /// <param name="storeParameterInfos">List Store and ListList Parameter</param>
        /// <returns>List msgErrors return from storeprocedure</returns>
        public List<string> ExecuteSProcedureWithTransaction(List<StoreParameterInfo> storeParameterInfos)
        {
            var msgErrors = new List<string>();
            bool isSuccess = true;
            List<object> result = new List<object>();
            using (MySqlConnection connection = new MySqlConnection(StrConnection))
            {
                connection.Open();
                using (MySqlTransaction transaction = connection.BeginTransaction())
                {
                    using (MySqlCommand cmd = connection.CreateCommand())
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Transaction = transaction;
                        cmd.Connection = connection;

                        for (int p = 0; p < storeParameterInfos.Count; p++)
                        {
                            try
                            {
                                cmd.CommandText = storeParameterInfos[p].StoreProcedureName;
                                int parameterInput = storeParameterInfos[p].StoreProcedureParams == null ? 0 : (storeParameterInfos[p].StoreProcedureParams.Count) / 2;
                                int j = 0;

                                if (cmd.Parameters != null && cmd.Parameters.Count > 0)
                                    cmd.Parameters.Clear();

                                for (int i = 0; i < parameterInput; i++)
                                {
                                    string paramName = Convert.ToString(storeParameterInfos[p].StoreProcedureParams[j++]);
                                    object value = storeParameterInfos[p].StoreProcedureParams[j++];
                                    if (paramName.ToLower().Contains("json"))
                                    {
                                        cmd.Parameters.Add(new MySqlParameter()
                                        {
                                            ParameterName = paramName,
                                            Value = value ?? DBNull.Value,
                                            MySqlDbType = MySqlDbType.Text
                                        });
                                    }
                                    else
                                    {
                                        cmd.Parameters.Add(new MySqlParameter(paramName, value ?? DBNull.Value));
                                    }
                                }

                                cmd.ExecuteNonQuery();
                            }
                            catch (Exception exception)
                            {
                                isSuccess = false;
                                msgErrors.Add(exception.StackTrace);
                            }
                        }
                    }
                    if (isSuccess)
                        transaction.Commit();
                    else
                    {
                        try
                        {
                            transaction.Rollback();
                        }
                        catch (Exception ex) { }
                    }
                }
            }
            return msgErrors;
        }
        /// <summary>
        ///  Execute Scalar Procedure query
        /// </summary>
        /// <param name="msgError">String.Empty when run query success or Message Error when run query happen issue</param>        
        /// <param name="sprocedureName">Procedure Name</param>
        /// <param name="paramObjects">List Param Objects, Each Item include 'ParamName' and 'ParamValue'</param>
        /// <returns>Value return from Store</returns>
        public object ExecuteScalarSProcedure(out string msgError, string sprocedureName, params object[] paramObjects)
        {
            msgError = "";
            object result = null;
            MySqlConnection connection = new MySqlConnection(StrConnection);

            try
            {
                MySqlCommand cmd = new MySqlCommand { CommandType = CommandType.StoredProcedure, CommandText = sprocedureName };
                connection.Open();
                cmd.Connection = connection;
                int parameterInput = (paramObjects.Length) / 2;
                int j = 0;
                for (int i = 0; i < parameterInput; i++)
                {
                    string paramName = Convert.ToString(paramObjects[j++]);
                    object value = paramObjects[j++];
                    if (paramName.ToLower().Contains("jsonb"))
                    {
                        cmd.Parameters.Add(new MySqlParameter()
                        {
                            ParameterName = paramName,
                            Value = value ?? DBNull.Value,
                            MySqlDbType = MySqlDbType.Text
                        });
                    }
                    else if (paramName.ToLower().Contains("json"))
                    {
                        cmd.Parameters.Add(new MySqlParameter()
                        {
                            ParameterName = paramName,
                            Value = value ?? DBNull.Value,
                            MySqlDbType = MySqlDbType.Text
                        });
                    }
                    else
                    {
                        cmd.Parameters.Add(new MySqlParameter(paramName, value ?? DBNull.Value));
                    }
                }

                result = cmd.ExecuteScalar();
                cmd.Dispose();
            }
            catch (Exception exception)
            {
                result = null;
                msgError = exception.ToString();
            }
            finally
            {
                connection.Close();
            }
            return result;
        }
        /// <summary>
        /// Execute Scalar Procedure query List store and command
        /// </summary>
        /// <param name="msgErrors">List Error message</param>
        /// <param name="storeParameterInfos">List Store and ListList Parameter</param>
        /// <returns>List Object return from storeprocedure</returns>
        public List<object> ExecuteScalarSProcedure(out List<string> msgErrors, List<StoreParameterInfo> storeParameterInfos)
        {
            msgErrors = new List<string>();
            List<object> result = new List<object>();
            using (MySqlConnection connection = new MySqlConnection(StrConnection))
            {
                connection.Open();

                using (MySqlCommand cmd = new MySqlCommand { CommandType = CommandType.StoredProcedure, Connection = connection })
                {

                    for (int p = 0; p < storeParameterInfos.Count; p++)
                    {
                        try
                        {
                            cmd.CommandText = storeParameterInfos[p].StoreProcedureName;
                            int parameterInput = storeParameterInfos[p].StoreProcedureParams == null ? 0 : (storeParameterInfos[p].StoreProcedureParams.Count) / 2;
                            int j = 0;

                            if (cmd.Parameters != null && cmd.Parameters.Count > 0)
                                cmd.Parameters.Clear();

                            for (int i = 0; i < parameterInput; i++)
                            {
                                string paramName = Convert.ToString(storeParameterInfos[p].StoreProcedureParams[j++]);
                                object value = storeParameterInfos[p].StoreProcedureParams[j++];
                                if (paramName.ToLower().Contains("json"))
                                {
                                    cmd.Parameters.Add(new MySqlParameter()
                                    {
                                        ParameterName = paramName,
                                        Value = value ?? DBNull.Value,
                                        MySqlDbType = MySqlDbType.Text
                                    });
                                }
                                else
                                {
                                    cmd.Parameters.Add(new MySqlParameter(paramName, value ?? DBNull.Value));
                                }
                            }

                            var rresult = cmd.ExecuteScalar();
                            result.Add(rresult);
                        }
                        catch (Exception exception)
                        {
                            result.Add(null);
                            msgErrors.Add(exception.StackTrace);
                        }
                    }
                }
            }
            return result;
        }
        /// <summary>
        /// Execute Scalar Procedure query List store with transaction
        /// </summary>
        /// <param name="msgErrors">List Error message</param>
        /// <param name="storeParameterInfos">List Store and ListList Parameter</param>
        /// <returns>List Object return from storeprocedure</returns>
        public List<object> ExecuteScalarSProcedureWithTransaction(out List<string> msgErrors, List<StoreParameterInfo> storeParameterInfos)
        {
            msgErrors = new List<string>();
            bool isSuccess = true;
            List<object> result = new List<object>();
            using (MySqlConnection connection = new MySqlConnection(StrConnection))
            {
                connection.Open();
                using (MySqlTransaction transaction = connection.BeginTransaction())
                {
                    using (MySqlCommand cmd = connection.CreateCommand())
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Transaction = transaction;
                        cmd.Connection = connection;

                        for (int p = 0; p < storeParameterInfos.Count; p++)
                        {
                            try
                            {
                                cmd.CommandText = storeParameterInfos[p].StoreProcedureName;
                                int parameterInput = storeParameterInfos[p].StoreProcedureParams == null ? 0 : (storeParameterInfos[p].StoreProcedureParams.Count) / 2;
                                int j = 0;

                                if (cmd.Parameters != null && cmd.Parameters.Count > 0)
                                    cmd.Parameters.Clear();

                                for (int i = 0; i < parameterInput; i++)
                                {
                                    string paramName = Convert.ToString(storeParameterInfos[p].StoreProcedureParams[j++]);
                                    object value = storeParameterInfos[p].StoreProcedureParams[j++];
                                    if (paramName.ToLower().Contains("json"))
                                    {
                                        cmd.Parameters.Add(new MySqlParameter()
                                        {
                                            ParameterName = paramName,
                                            Value = value ?? DBNull.Value,
                                            MySqlDbType = MySqlDbType.Text
                                        });
                                    }
                                    else
                                    {
                                        cmd.Parameters.Add(new MySqlParameter(paramName, value ?? DBNull.Value));
                                    }
                                }

                                var rresult = cmd.ExecuteScalar();
                                result.Add(rresult);
                            }
                            catch (Exception exception)
                            {
                                isSuccess = false;
                                result.Add(null);
                                msgErrors.Add(exception.StackTrace);
                            }
                        }
                    }
                    if (isSuccess)
                        transaction.Commit();
                    else
                    {
                        try
                        {
                            transaction.Rollback();
                        }
                        catch (Exception ex) { }
                    }
                }
            }
            return result;
        }
        /// <summary>
        ///  Execute Scalar Procedure query with transaction
        /// </summary>
        /// <param name="msgError">String.Empty when run query success or Message Error when run query happen issue</param>        
        /// <param name="sprocedureName">Procedure Name</param>
        /// <param name="paramObjects">List Param Objects, Each Item include 'ParamName' and 'ParamValue'</param>
        /// <returns>Value return from Store</returns>
        public object ExecuteScalarSProcedureWithTransaction(out string msgError, string sprocedureName, params object[] paramObjects)
        {
            msgError = "";
            object result = null;
            using (MySqlConnection connection = new MySqlConnection(StrConnection))
            {
                connection.Open();
                using (MySqlTransaction transaction = connection.BeginTransaction())
                {
                    try
                    {
                        MySqlCommand cmd = connection.CreateCommand();
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandText = sprocedureName;
                        cmd.Transaction = transaction;
                        cmd.Connection = connection;

                        int parameterInput = (paramObjects.Length) / 2;
                        int j = 0;
                        for (int i = 0; i < parameterInput; i++)
                        {
                            string paramName = Convert.ToString(paramObjects[j++]);
                            object value = paramObjects[j++];
                            if (paramName.ToLower().Contains("json"))
                            {
                                cmd.Parameters.Add(new MySqlParameter()
                                {
                                    ParameterName = paramName,
                                    Value = value ?? DBNull.Value,
                                    MySqlDbType = MySqlDbType.Text
                                });
                            }
                            else
                            {
                                cmd.Parameters.Add(new MySqlParameter(paramName, value ?? DBNull.Value));
                            }
                        }

                        result = cmd.ExecuteScalar();
                        cmd.Dispose();
                        transaction.Commit();
                    }
                    catch (Exception exception)
                    {

                        result = null;
                        msgError = exception.ToString();
                        try
                        {
                            transaction.Rollback();
                        }
                        catch (Exception ex) { }
                    }
                    finally
                    {
                        connection.Close();
                    }
                }
            }
            return result;
        }
        /// <summary>
        /// Execute Procedure return DataTale
        /// </summary>
        /// <param name="msgError">String.Empty when run query success or Message Error when run query happen issue</param>
        /// <param name="sprocedureName">Procedure Name</param>
        /// <param name="paramObjects">List Param Objects, Each Item include 'ParamName' and 'ParamValue'</param>
        /// <returns>Table result</returns>
        public DataTable ExecuteSProcedureReturnDataTable(out string msgError, string sprocedureName, params object[] paramObjects)
        {
            DataTable tb = new DataTable();
            MySqlConnection connection;
            try
            {
                MySqlCommand cmd = new MySqlCommand { CommandType = CommandType.StoredProcedure, CommandText = sprocedureName };
                connection = new MySqlConnection(StrConnection);
                cmd.Connection = connection;

                int parameterInput = (paramObjects.Length) / 2;

                int j = 0;
                for (int i = 0; i < parameterInput; i++)
                {
                    string paramName = Convert.ToString(paramObjects[j++]).Trim();
                    object value = paramObjects[j++];
                    if (paramName.ToLower().Contains("json"))
                    {
                        cmd.Parameters.Add(new MySqlParameter()
                        {
                            ParameterName = paramName,
                            Value = value ?? DBNull.Value,
                            MySqlDbType = MySqlDbType.Text
                        });
                    }
                    else
                    {
                        cmd.Parameters.Add(new MySqlParameter(paramName, value ?? DBNull.Value));
                    }
                }

                MySqlDataAdapter ad = new MySqlDataAdapter(cmd);
                ad.Fill(tb);
                cmd.Dispose();
                ad.Dispose();
                connection.Dispose();
                msgError = "";
            }
            catch (Exception exception)
            {
                tb = null;
                msgError = exception.ToString();
            }
            return tb;
        }
        /// <summary>
        /// Execute Procedure return DataSet
        /// </summary>
        /// <param name="msgError">String.Empty when run query success or Message Error when run query happen issue</param>
        /// <param name="sprocedureName">Procedure Name</param>
        /// <param name="paramObjects">List Param Objects, Each Item include 'ParamName' and 'ParamValue'</param>
        /// <returns>DataSet result</returns>
        public DataSet ExecuteSProcedureReturnDataset(out string msgError, string sprocedureName, params object[] paramObjects)
        {
            DataSet tb = new DataSet();
            MySqlConnection connection;
            try
            {
                MySqlCommand cmd = new MySqlCommand { CommandType = CommandType.StoredProcedure, CommandText = sprocedureName };
                connection = new MySqlConnection(StrConnection);
                cmd.Connection = connection;

                int parameterInput = (paramObjects.Length) / 2;

                int j = 0;
                for (int i = 0; i < parameterInput; i++)
                {
                    string paramName = Convert.ToString(paramObjects[j++]);
                    object value = paramObjects[j++];
                    if (paramName.ToLower().Contains("json"))
                    {
                        cmd.Parameters.Add(new MySqlParameter()
                        {
                            ParameterName = paramName,
                            Value = value ?? DBNull.Value,
                            MySqlDbType = MySqlDbType.Text
                        });
                    }
                    else
                    {
                        cmd.Parameters.Add(new MySqlParameter(paramName, value ?? DBNull.Value));
                    }
                }

                MySqlDataAdapter ad = new MySqlDataAdapter(cmd);
                ad.Fill(tb);
                cmd.Dispose();
                ad.Dispose();
                connection.Dispose();
                msgError = "";
            }
            catch (Exception exception)
            {
                tb = null;
                msgError = exception.ToString();
            }

            return tb;
        }
        /// <summary>
        /// Execute Procedure None Query
        /// </summary>
        /// <param name="npgMySqlConnection">NpgMySqlConnection: Connection use to connect to PostGresDB</param>
        /// <param name="sprocedureName">Procedure Name</param>
        /// <param name="paramObjects">List Param Objects, Each Item include 'ParamName' and 'ParamValue'</param>
        /// <returns>String.Empty when run query success or Message Error when run query happen issue</returns>
        public string ExecuteSProcedure(MySqlConnection npgMySqlConnection, string sprocedureName, params object[] paramObjects)
        {
            string result = "";
            // NpgMySqlConnection connection = new NpgMySqlConnection(strConnectionString);
            try
            {
                MySqlCommand cmd = new MySqlCommand { CommandType = CommandType.StoredProcedure, CommandText = sprocedureName };
                if (npgMySqlConnection.State != ConnectionState.Open)
                {
                    return "CONNECTION_NOT_OPENING";
                }

                cmd.Connection = npgMySqlConnection;
                int parameterInput = (paramObjects.Length) / 2;
                int j = 0;
                for (int i = 0; i < parameterInput; i++)
                {
                    string paramName = Convert.ToString(paramObjects[j++]);
                    object value = paramObjects[j++];
                    if (paramName.ToLower().Contains("json"))
                    {
                        cmd.Parameters.Add(new MySqlParameter()
                        {
                            ParameterName = paramName,
                            Value = value ?? DBNull.Value,
                            MySqlDbType = MySqlDbType.Text
                        });
                    }
                    else
                    {
                        cmd.Parameters.Add(new MySqlParameter(paramName, value ?? DBNull.Value));
                    }
                }
                cmd.ExecuteNonQuery();
                cmd.Dispose();
            }
            catch (Exception exception)
            {
                result = exception.ToString();
            }
            return result;
        }
        /// <summary>
        /// Execute Procedure return List Object Results
        /// </summary>
        /// <param name="msgError">String.Empty when run query success or Message Error when run query happen issue</param>
        /// <param name="sprocedureName">Procedure Name</param>
        /// <param name="outputParamCountNumber">outputParam Count Number</param>
        /// <param name="paramObjects">List Param Objects, Each Item include 'ParamName' and 'ParamValue'</param>
        /// <returns>List Object Result in query</returns>
        public List<Object> ReturnValuesFromExecuteSProcedure(out string msgError, string sprocedureName, int outputParamCountNumber, params object[] paramObjects)
        {
            List<Object> result = new List<Object>();
            MySqlConnection connection = new MySqlConnection(StrConnection);
            try
            {
                MySqlCommand cmd = new MySqlCommand { CommandType = CommandType.StoredProcedure, CommandText = sprocedureName };
                connection.Open();
                cmd.Connection = connection;

                int numberOutput = outputParamCountNumber * 2;

                int parameterInput = (paramObjects.Length - numberOutput) / 2;

                int j = 0;
                for (int i = 0; i < parameterInput; i++)
                {
                    string paramName = Convert.ToString(paramObjects[j++]);
                    object value = paramObjects[j++];
                    if (paramName.ToLower().Contains("json"))
                    {
                        cmd.Parameters.Add(new MySqlParameter()
                        {
                            ParameterName = paramName,
                            Value = value ?? DBNull.Value,
                            MySqlDbType = MySqlDbType.Text
                        });
                    }
                    else
                    {
                        cmd.Parameters.Add(new MySqlParameter(paramName, value ?? DBNull.Value));
                    }
                }

                for (int i = parameterInput * 2 - numberOutput; i < parameterInput * 2; i++)
                {
                    string paramName = Convert.ToString(paramObjects[j++]);
                    object value = paramObjects[j++];
                    cmd.Parameters.Add(new MySqlParameter(paramName, value ?? DBNull.Value) { Direction = ParameterDirection.Output, Size = 1000, IsNullable = true });
                }

                cmd.ExecuteNonQuery();

                foreach (MySqlParameter MySqlParameter in cmd.Parameters)
                    if (MySqlParameter.Direction == ParameterDirection.Output)
                        result.Add(MySqlParameter.Value);

                cmd.Dispose();
                msgError = "";
            }
            catch (Exception exception)
            {
                msgError = exception.ToString();
            }
            finally
            {
                connection.Close();
            }
            return result;
        }
        #endregion
    }
}
