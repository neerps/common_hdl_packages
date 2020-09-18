--====================================================================================

-- Target languange: VHDL-2008.

-- This package contains types that can be useful for any design

--====================================================================================
--   Copyright 2020 Igor Fomin

--   Licensed under the Apache License, Version 2.0 (the "License");
--   you may not use this file except in compliance with the License.
--   You may obtain a copy of the License at

--       http://www.apache.org/licenses/LICENSE-2.0

--   Unless required by applicable law or agreed to in writing, software
--   distributed under the License is distributed on an "AS IS" BASIS,
--   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--   See the License for the specific language governing permissions and
--   limitations under the License. 
--====================================================================================
library IEEE;
    use IEEE.STD_LOGIC_1164.all;
    use IEEE.NUMERIC_STD.all;
--====================================================================================
package common_types is
--------------------------------------------------------------------------------------
    type t_arr_of_slv is array (natural range <>) of std_logic_vector;
--------------------------------------------------------------------------------------
    type t_arr_of_unsign is array (natural range <>) of unsigned;
--------------------------------------------------------------------------------------
    type t_arr_of_sign is array (natural range <>) of signed;
--------------------------------------------------------------------------------------
    type t_arr_of_arr_slv is array (natural range <>) of t_arr_of_slv;
--------------------------------------------------------------------------------------
    type t_arr_of_arr_unsign is array (natural range <>) of t_arr_of_unsign;
--------------------------------------------------------------------------------------
    type t_arr_of_int is array (natural range <>) of integer;
--------------------------------------------------------------------------------------
    type t_arr_of_nat is array (natural range <>) of natural;
--------------------------------------------------------------------------------------
end package;