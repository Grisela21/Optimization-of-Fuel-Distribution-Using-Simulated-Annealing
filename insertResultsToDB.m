function insertResultsToDB(results, conn, depot)
    % Check if the connection is valid
    if isempty(conn) || ~isvalid(conn)
        error('Database connection is not valid.');
    end

    % Convert depot coordinates to a string
    depotStr = sprintf('%.4f, %.4f', depot(1), depot(2));

    % Prepare the SQL query template
    sqlQueryTemplate = ['INSERT INTO [SPEED].[dbo].[ViaggiMover] (data, km, tempo, tempoScarico, idMezzo, ', ...
                        'creato, basePartenza, baseCarico, baseArrivo, oraPartenza, numViaggio, trasmesso, ', ...
                        'stato, id_vettore, selezionato) VALUES (''%s'', %f, %f, %s, %d, %d, ''%s'', ''%s'', ''%s'', ''%s'', %d, %d, %d, %d, %d)'];

    % Loop through each result and insert into the database
    % for idx = 1:length(results)
    %     res = results{idx};

        % Prepare the SQL query with the result data
        sqlQuery = sprintf(sqlQueryTemplate, ...
                            '2024-08-01', ... % Assuming this is a placeholder date, update as needed
                            res.FinalCost, ...
                            res.TravelTimeHoursPolmoni, ...
                            'NULL', ... % Assuming tempoScarico is not provided
                            NaN, ... % Assuming idMezzo is not provided
                            NaN, ... % Assuming created is not provided
                            depotStr, ... % Use formatted depot coordinates
                            depotStr, ... % Assuming baseCarico and baseArrivo should be depot coordinates
                            depotStr, ... % Assuming baseArrivo should be depot coordinates
                            '05:00:00', ... % Assuming a default time, update as needed
                            NaN, ... % Assuming numViaggio is not provided
                            NaN, ... % Assuming trasmesso is not provided
                            NaN, ... % Assuming stato is not provided
                            NaN, ... % Assuming id_vettore is not provided
                            NaN); % Assuming selezionato is not provided

        % Display the SQL query for debugging
        disp(['Executing SQL Query: ', sqlQuery]);

        % Execute the SQL query
        try
            exec(conn, sqlQuery);
        catch ME
            disp(['Failed to insert result for ClusterID ', num2str(res.ClusterID), ': ', ME.message]);
        end
   % end

    % Commit the transaction if needed
    % Uncomment if your database supports transactions
    % conn.commit();

    disp('Results inserted successfully.');
end
