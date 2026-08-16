// FPDB
// Copyright (C) 2026 Bert Geens
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.
//
package be.lair.fpdb.architecture;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import javax.sql.DataSource;
import org.flywaydb.core.Flyway;
import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

@ActiveProfiles({"test", "sqlite"})
@SpringBootTest
class SqliteMigrationIT {

    private final Logger log = LoggerFactory.getLogger(getClass());

    @Autowired private DataSource dataSource;

    /** Verify that migrations are idempotent. */
    @Test
    void idempotencyTest() {
        log.info("Dropping schema history");
        try (Connection connection = dataSource.getConnection();
                Statement statement = connection.createStatement()) {
            statement.execute("DROP TABLE flyway_schema_history");
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        log.info("Re-running migrations on SQLite");
        Flyway flyway = Flyway.configure().baselineOnMigrate(true).dataSource(dataSource).load();

        assertDoesNotThrow(flyway::migrate);
    }
}
