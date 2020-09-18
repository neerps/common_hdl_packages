--====================================================================================

-- Target language: VHDL-93 and above.

-- Package that contains functions which can be useful for any design

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
    use IEEE.MATH_REAL.all;
--------------------------------------------------------------------------------------	
package common_functions is
--------------------------------------------------------------------------------------
    -- Function that takes natural number and returns it powered to n
    -- : param p_num_for_calc : number which we want to increase
    -- : param p_power : power of a number which we want to get
    -- : returns : powered number
    function calc_power_of_two (
        p_num_for_calc      : natural;
        p_power             : natural
    )
    return natural;
--------------------------------------------------------------------------------------
    -- Function to calculate a ceiled result of a divison of a natural number by 
    -- some natural number. 
    -- Can be used for synthesis to calculate constants for port width, timer max values, etc. 
    -- : param p_num : number to divide
    -- : param p_div : divisor
    -- : returns : divided number, ceiled
    function ceil_div (
        p_num               : natural;
        p_div               : natural
    )
    return natural;
--------------------------------------------------------------------------------------
    /* Function to calc log2 of natural number with math_real. 
    It can be used to define a port width for the synthesys.
    : param p_inp_numwords : argument of the log function 
    (number from which we take log)
    : returns : log2 of an input
    */
    function ceil_log2 (
        p_inp_numwords      : natural
    ) 
    return natural;
--------------------------------------------------------------------------------------
    -- Function that checks parity for a natural number. 
    -- Intended for calculation of constants for ports, counters, etc.
    -- : param p_num_to_check : natural number to check for parity
    -- : returns : result of a check as sl bit
    function check_num_par (
        p_num_to_check      : natural
    )
    return std_logic;
--------------------------------------------------------------------------------------
    -- Function to fill some bit vector with copies of a signle bit signal 
    -- : param p_vec_size : vector to fill with a signal
    -- : param p_sig_in : signal which is used to fill a vector
    -- : returns : vector filled with a signal
    function fill_slv (  
        p_vec_size          : natural range 0 to 32;
        p_sig_in            : std_logic
    )
    return std_logic_vector;
--------------------------------------------------------------------------------------
    -- Function to create p_inp_vector'sized AND gate 
    -- : param p_inp_vector : vector of bits to AND
    -- : returns : result of AND
    function reduct_and (
        p_inp_vector        : std_logic_vector
    )
    return std_logic;
-------------------------------------------------------------------------------------- 
    -- Function to create p_inp_vector'sized OR gate 
    -- : param p_inp_vector : vector of bits to OR
    -- : returns : result of OR
    function reduct_or (
        p_inp_vector        : std_logic_vector
    )
    return std_logic;
--------------------------------------------------------------------------------------
    -- Function to create p_inp_vector'sized XOR gate 
    -- : param p_inp_vector : vector of bits to XOR
    -- : returns : result of XOR
    function reduct_xor (
        p_inp_vector        : std_logic_vector
    )
    return std_logic;
--------------------------------------------------------------------------------------
    -- Function to select one bit from slv vector. 
    -- It primary intended use is select clock port within generate statement 
    -- : param p_ind_to_out : index of a bit within a vector
    -- : param p_inp_vector : vector from which we select a bit for output
    -- : returns : selected bit from an input vector
    function sel_slv_bit (
        p_ind_to_out        : natural; 
        p_inp_vector        : std_logic_vector
    ) 
    return std_logic;
--------------------------------------------------------------------------------------
    -- Function to change the byte endiannes inside the double word (32 bit) 
    -- : param p_inp_dword : double word to swap bytes
    -- : returns : double word with swapped endiannes
    function swap_slv_dw (
        p_inp_dword         : std_logic_vector(31 downto 0)
    ) 
    return std_logic_vector;
--------------------------------------------------------------------------------------
end package common_functions;
--====================================================================================
package body common_functions is
--------------------------------------------------------------------------------------
    function calc_power_of_two (
        p_num_for_calc      : natural;
        p_power             : natural
    )
    return natural is

        variable v_num_powered  : natural;

    begin

        -- mind that "**" function is overloaded and accepts as real, as integers alike.
        -- But it returns real, so need to cast to natural
        v_num_powered   := natural(p_num_for_calc**p_power);
        
        return v_num_powered;

    end calc_power_of_two;
--------------------------------------------------------------------------------------
    function ceil_div (
        p_num               : natural;
        p_div               : natural
    )
    return natural is

        variable v_tmp  : natural := 0;
        
    begin
        
        if p_num < p_div then
            v_tmp   := 1;
            
        else
            v_tmp   := natural(ceil(real(p_num)/real(p_div)));
            
        end if;

        return v_tmp;
        
    end ceil_div;
--------------------------------------------------------------------------------------
    function ceil_log2 (
        p_inp_numwords      : natural
    ) 
    return natural is
        
        variable v_tmp: natural := 0;
        
        begin
        
            if p_inp_numwords < 2 then
                v_tmp   := 1;

            else
                v_tmp   := natural(ceil(log2(real(p_inp_numwords))));

            end if;
            
        return v_tmp;
        
    end ceil_log2;
--------------------------------------------------------------------------------------
    function check_num_par (
        p_num_to_check      : natural
    )
    return std_logic is

        variable v_num_to_vec   : signed(31 downto 0);
        variable v_par_mark     : std_logic;
        
    begin
        
        -- convert input number to vector
        v_num_to_vec    := to_signed(p_num_to_check, v_num_to_vec'length);
        
        -- Get number's parity
        v_par_mark      := v_num_to_vec(0);
        
        return v_par_mark;
        
    end check_num_par;
--------------------------------------------------------------------------------------
    function fill_slv (  
        p_vec_size              : natural range 0 to 32;
        p_sig_in                : std_logic
    )
    return std_logic_vector is
    
        variable v_result   : std_logic_vector(p_vec_size-1 downto 0);
        
    begin
    
        for i in p_vec_size-1 downto 0 loop
            v_result(i) := p_sig_in;
        end loop;
        
        return v_result;
    
    end fill_slv;
--------------------------------------------------------------------------------------
    function reduct_and (
        p_inp_vector            : std_logic_vector
    )
    return std_logic is

        variable v_res_and  : std_logic:= '1';

    begin
        
        for i in p_inp_vector'range loop
            v_res_and   := v_res_and and p_inp_vector(i);
        end loop;
        
        return v_res_and;

    end reduct_and;
--------------------------------------------------------------------------------------
    function reduct_or (
        p_inp_vector	        : std_logic_vector
    )
    return std_logic is

        variable v_res_ored : std_logic:= '0';

    begin
        
        for i in p_inp_vector'range loop
            v_res_ored  := v_res_ored or p_inp_vector(i);
        end loop;
        
        return v_res_ored;

    end reduct_or;
--------------------------------------------------------------------------------------
    function reduct_xor (
        p_inp_vector            : std_logic_vector
    )
    return std_logic is

        variable v_res_xor  : std_logic;
        
    begin

        v_res_xor	:= '0';

        for i in p_inp_vector'range loop
            v_res_xor	:= v_res_xor xor p_inp_vector(i);
        end loop;

        return v_res_xor;

    end reduct_xor;
--------------------------------------------------------------------------------------
    function sel_slv_bit (
        p_ind_to_out            : natural;
        p_inp_vector            : std_logic_vector
    ) 
    return std_logic is
    
        variable v_res  : std_logic;
        
    begin
        
        v_res   := p_inp_vector(p_ind_to_out);
        
        return v_res;
        
    end sel_slv_bit;
--------------------------------------------------------------------------------------
    function swap_slv_dw (
        p_inp_dword             : std_logic_vector(31 downto 0)
    ) 
    return std_logic_vector is

        variable v_tmp  : std_logic_vector(31 downto 0);
        
        begin

            v_tmp(7 downto 0)   := p_inp_dword(31 downto 24);
            v_tmp(15 downto 8)  := p_inp_dword(23 downto 16);
            v_tmp(23 downto 16) := p_inp_dword(15 downto 8);
            v_tmp(31 downto 24) := p_inp_dword(7 downto 0);		
            
            return std_logic_vector(v_tmp);

    end swap_slv_dw;
--------------------------------------------------------------------------------------
end package body common_functions;