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
package be.lair.fpdb;

import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.modulith.core.ApplicationModules;

class ModulesIT {

    private final Logger log = LoggerFactory.getLogger(ModulesIT.class);

    private final ApplicationModules modules = ApplicationModules.of(Main.class);

    @Test
    void verifyModuleStructure() {
        // print out structure
        log.info(modules.toString());

        // verify structure
        modules.verify();

        // generate diagrams
        // new Documenter(modules).writeModulesAsPlantUml().writeIndividualModulesAsPlantUml();
    }
}
