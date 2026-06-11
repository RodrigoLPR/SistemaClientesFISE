package com.ayf.sistemaclientesfise.util;

import com.google.common.base.Preconditions;
import org.apache.commons.lang3.StringUtils;

public class ValidadorCliente {

    public static void validarDatosCliente(String dni, String nombres, String apellidos, String direccion) {

        Preconditions.checkArgument(StringUtils.isNotBlank(dni), "El DNI es obligatorio");
        Preconditions.checkArgument(StringUtils.isNotBlank(nombres), "Los nombres son obligatorios");
        Preconditions.checkArgument(StringUtils.isNotBlank(apellidos), "Los apellidos son obligatorios");
        Preconditions.checkArgument(StringUtils.isNotBlank(direccion), "La dirección es obligatoria");

        Preconditions.checkArgument(dni.length() == 8, "El DNI debe tener 8 dígitos");
        Preconditions.checkArgument(StringUtils.isNumeric(dni), "El DNI solo debe contener números");
    }
}