
# ######################################################################## #
# File:         lib/xqsr3/doc_.rb
#
# Purpose:      Documentation of the ::Xqsr3 modules
#
# Created:      10th June 2016
# Updated:      12th April 2019
#
# Home:         http://github.com/synesissoftware/xqsr3
#
# Author:       Matthew Wilson
#
# Copyright (c) 2016-2019, Matthew Wilson and Synesis Software
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#
# * Redistributions of source code must retain the above copyright notice,
#   this list of conditions and the following disclaimer.
#
# * Redistributions in binary form must reproduce the above copyright
#   notice, this list of conditions and the following disclaimer in the
#   documentation and/or other materials provided with the distribution.
#
# * Neither the names of the copyright holder nor the names of its
#   contributors may be used to endorse or promote products derived from
#   this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
# IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
# LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# ######################################################################## #


=begin
=end

# Main module for Xqsr3 library
#
# === Subordinate modules of interest
# * ::Xqsr3::CommandLineUtilities
# * ::Xqsr3::Containers
# * ::Xqsr3::Diagnostics
# * ::Xqsr3::IO
# * ::Xqsr3::Quality
# * ::Xqsr3::StringUtilities
module Xqsr3

	# Array utilities
	#
	# === Subordinate modules of interest
	# * ::Xqsr3::ArrayUtilities::JoinWithOr
	module ArrayUtilities
	end # module ArrayUtilities

	# Command-line Utilities
	#
	# === Subordinate modules of interest
	# * ::Xqsr3::CommandLineUtilities::MapOptionString
	module CommandLineUtilities
	end # module CommandLineUtilities

	# Containers
	#
	module Containers
	end # module Containers

	# Conversion
	#
	module Conversion
	end # module Conversion

	# Diagnostic facilities
	#
	# === Subordinate modules of interest
	# * ::Xqsr3::Diagnostics::ExceptionUtilities
	# * ::Xqsr3::Diagnostics::InspectBuilder
	# * ::Xqsr3::Diagnostics::Exceptions::WithCause
	#
	module Diagnostics

		# Exception-related utilities
		#
		# === Components of interest
		# * ::Xqsr3::Diagnostics::ExceptionUtilities::raise_with_options
		#
		module ExceptionUtilities
		end # module ExceptionUtilities

		# Inspect builder
		#
		module InspectBuilder
		end # module InspectBuilder

		# Exception-related utilities
		#
		# === Components of interest
		# * ::Xqsr3::Diagnostics::Exceptions::WithCause
		#
		module Exceptions
		end # module Exceptions
	end # module Diagnostics

	# Hash utilities
	#
	# === Subordinate modules of interest
	# * ::Xqsr3::HashUtilities::DeepTransform
	# * ::Xqsr3::HashUtilities::KeyMatching
	module HashUtilities

		# Exception-related utilities
		#
		# === Components of interest
		# * ::Xqsr3::Diagnostics::HashUtilities::deep_transform
		# * ::Xqsr3::Diagnostics::HashUtilities::deep_transform!
		#
		module DeepTransform
		end # module DeepTransform
	end # module HashUtilities

	# IO
	#
	class IO
	end # class IO

	# Quality
	#
	# === Subordinate modules of interest
	# * ::Xqsr3::Quality::ParameterChecking
	module Quality
	end # module Quality

	# String utilities
	#
	# === Subordinate modules of interest
	# * ::Xqsr3::StringUtilities::EndsWith
	# * ::Xqsr3::StringUtilities::NilIfEmpty
	# * ::Xqsr3::StringUtilities::NilIfWhitespace
	# * ::Xqsr3::StringUtilities::QuoteIf
	# * ::Xqsr3::StringUtilities::StartsWith
	# * ::Xqsr3::StringUtilities::ToSymbol
	# * ::Xqsr3::StringUtilities::Truncate
	module StringUtilities

=begin
		 module EndsWith
		 end # module EndsWith
		 module NilIfEmpty
		 end # module NilIfEmpty
		 module NilIfWhitespace
		 end # module NilIfWhitespace
		 module QuoteIf
		 end # module QuoteIf
		 module StartsWith
		 end # module StartsWith
		 module ToSymbol
		 end # module ToSymbol
		 module Truncate
		 end # module Truncate
=end
	end # module StringUtilities
end # module Xqsr3

# Standard class, extended with methods:
#
# - Array#join_with_or
class Array; end

# Standard module, extended with methods:
#
# - Enumerable#collect_with_index
# - Enumerable#detect_map
# - Enumerable#unique
module Enumerable; end

# Standard class, extended with methods:
#
# - Hash#deep_transform
# - Hash#has_match?
# - Hash#match
class Hash; end

# Standard class, extended with methods:
#
# - IO#writelines
class IO; end

# Standard module, extended with methods:
#
# - Kernel::Integer
# - Kernel#raise_with_options
module Kernel; end

# Standard class, extended with methods:
#
# - String#ends_with?
# - String#map_option_string
# - String#nil_if_empty
# - String#nil_if_whitespace
# - String#quote_if
# - String#starts_with?
# - String#to_bool
# - String#to_symbol
# - String#truncate
class String; end

# Standard module
module Test

	# Standard module
	module Unit

		# Standard module
		#
		# === Components of interest
		# * ::Test::Unit::Assertions#assert_eql
		# * ::Test::Unit::Assertions#assert_false
		# * ::Test::Unit::Assertions#assert_not
		# * ::Test::Unit::Assertions#assert_not_eql
		# * ::Test::Unit::Assertions#assert_raise_with_message
		# * ::Test::Unit::Assertions#assert_subclass_of
		# * ::Test::Unit::Assertions#assert_superclass_of
		# * ::Test::Unit::Assertions#assert_true
		# * ::Test::Unit::Assertions#assert_type_has_instance_methods
		module Assertions
		end # module Assertions
	end # module Unit
end # module Test


# ############################## end of file ############################# #


