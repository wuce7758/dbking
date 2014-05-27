package ${package};
		
import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter;

import org.sosostudio.dbunifier.Encoding;
import org.sosostudio.dbunifier.autocode.TimestampXmlAdapter;
import org.sosostudio.dbunifier.util.StringUtil;

/**
 * ${table.name}
 *
 * @author generated by db-unifier autocode
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "${table.name}")
public class ${table.definationName} implements Serializable {

	public static final String ${table.name} = "${table.name}";
	<#list table.columnList as column>

	public static final String ${column.name} = "${column.name}";
	</#list>
	
	private Encoding encoding;
	<#list table.columnList as column>
		<#if column.type == "STRING" || column.type == "NUMBER" || column.type == "TIMESTAMP">

			<#if column.primaryKey>
	@Id
			</#if>
	@Column(name = "${column.name}")
	private ${column.type.type} ${column.variableName};
		</#if>
	</#list>
	
	public ${table.definationName}(Encoding encoding) {
		this.encoding = encoding;
	}
	<#list table.columnList as column>
		<#if column.type == "STRING" || column.type == "NUMBER" || column.type == "TIMESTAMP">

			<#if column.type == "TIMESTAMP">
	@XmlJavaTypeAdapter(TimestampXmlAdapter.class)
			</#if>
	public ${column.type.type} get${column.definationName}() {
		return ${column.variableName};
	}

	public void set${column.definationName}(${column.type.type} ${column.variableName}) {
			<#if column.type == "STRING">
				<#if column.nationalString>
		this.${column.variableName} = ${column.variableName};
				<#else>
		this.${column.variableName} = StringUtil.substring(${column.variableName}, ${column.size}, encoding);
				</#if>
			<#else>
		this.${column.variableName} = ${column.variableName};
			</#if>
	}
		</#if>
	</#list>

}